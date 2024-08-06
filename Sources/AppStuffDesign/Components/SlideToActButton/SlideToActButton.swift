//
//  SlideToActButton.swift
//  AppStuffDesign
//
//  Created by Stephan Dowless on 7/7/24.
//

import SwiftUI

public struct SlideToActButton: View {
    @Environment(\.isEnabled) var isEnabled
    
    @State private var displayTitle = true
    @State private var labelOpacity: Double = 1.0
    @State private var maxWidth: CGFloat = .infinity
    @State private var performHintAnimation = true
    
    @State private var knobAlignment: Alignment = .leading
    @State private var knobOffset: CGFloat = 0.0
    @State private var knobOpacity: CGFloat = 1.0
    @State private var knobScale: CGFloat = 1.0
    
    @State private var loadingIndicatorOpacity: CGFloat = 0.0
    @State private var loadingIndicatorScale: CGFloat = 0.01
    
    @Binding private var isLoading: Bool
    
    private var title: String
    private var action: () -> Void
    
    public init(_ title: String, isLoading: Binding<Bool>, action: @escaping () -> Void) {
        _isLoading = isLoading
        self.title = title
        self.action = action
    }
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: knobAlignment) {
                RoundedRectangle(cornerRadius: .infinity)
                    .fill(Color(.systemBlue))
                
                if displayTitle {
                    Text(title)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, isLoading ? 0 : 56)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .opacity(labelOpacity)
                }
                
                ZStack {
                    SlideToActKnob(animate: $performHintAnimation)
                        .opacity(knobOpacity)
                        .scaleEffect(knobScale)
                    
                    if isLoading {
                        ProgressView()
                            .tint(.white)
                            .opacity(loadingIndicatorOpacity)
                            .scaleEffect(loadingIndicatorScale)
                            .frame(width: 48)
                        
                    }
                }
                .padding(.horizontal, 4)
                .offset(x: knobOffset)
                .animation(.bouncy, value: knobOffset)
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            onGestureChanged(gesture, geometry)
                        }
                        .onEnded { gesture in
                           onGestureEnd(gesture, geometry)
                        }
                )
            }
        }
        .frame(height: buttonSize)
        .frame(maxWidth: maxWidth)
        .task(id: isLoading) {
            if isLoading { action() }
            await performAnimation(type: isLoading ? .performAction : .revert)
        }
    }
}

private extension SlideToActButton {
    func onGestureChanged(_ gesture: DragGesture.Value, _ geometry: GeometryProxy) {
        guard !isLoading else { return }
        
        performHintAnimation = false
        
        if gesture.translation.width >= 0, gesture.translation.width <= geometry.size.width - buttonSize {
            knobOffset = gesture.translation.width
            labelOpacity = 1 - (gesture.translation.width / (geometry.size.width * offsetThreshold))
        }
    }
    
    func onGestureEnd(_ gesture: DragGesture.Value, _ geometry: GeometryProxy) {
        guard !isLoading else { return }
        
        let velocity = gesture.predictedEndLocation.x - gesture.location.x
        
        if gesture.translation.width > geometry.size.width * offsetThreshold, velocity >= 0 {
            isLoading = true
        } else {
            knobOffset = 0
            labelOpacity = 1
            performHintAnimation = true
        }
    }
    
    func performAnimation(type: AnimationType) async {
        switch type {
        case .performAction:
            displayTitle = false
            knobAlignment = .trailing
            knobOffset = 0
            labelOpacity = 0
            
            try? await Task.sleep(nanoseconds: 100_000_000)
            
            withAnimation(.linear(duration: 0.3)) {
                maxWidth = buttonSize
            }
            
            withAnimation(.easeOut(duration: 0.3)) {
                knobOpacity = 0
                knobScale = 0.01
            }
            
            withAnimation(.easeIn(duration: 0.2).delay(0.2)) {
                loadingIndicatorOpacity = 1.0
                loadingIndicatorScale = 1.0
            }
        case .revert:
            performHintAnimation = true
            knobAlignment = .leading
            
            withAnimation(.easeOut(duration: 0.2)) {
                loadingIndicatorOpacity = 0
                loadingIndicatorScale = 0.01
            }
            
            withAnimation(.linear(duration: 0.3).delay(0.1)) {
                maxWidth = .infinity
            }
            
            withAnimation(.easeIn(duration: 0.3).delay(0.1))  {
                knobOpacity = 1
                knobScale = 1
            }
            
            withAnimation(.easeIn(duration: 0.2).delay(0.2)) {
                displayTitle = true
                labelOpacity = 1
            }
        }
    }
}

private extension SlideToActButton {
    enum AnimationType {
        case performAction
        case revert
    }
    
    var buttonSize: CGFloat {
        48
    }
    
    var offsetThreshold: Double {
        0.70
    }
}

#Preview {
    SlideToActButton("Slide To Act", isLoading: .constant(false), action: {})
        .environment(\.isEnabled, true)
        .padding(.horizontal)
}
