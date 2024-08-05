//
//  SlideToActKnob.swift
//  AppStuffDesign
//
//  Created by Stephan Dowless on 7/7/24.
//

import SwiftUI

struct SlideToActKnob: View {
    @Environment(\.isEnabled) private var isEnabled
    
    @State private var hintWidth: CGFloat = 0
    
    @Binding private var animate: Bool
    
    private var size: CGFloat = 40
    private var timerInterval: Double = 4.0
    
    init(animate: Binding<Bool>) {
        _animate = animate
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: .infinity)
                .foregroundStyle(.white)
            
            HStack {
                Spacer()
                    .frame(width: hintWidth)
                    .onReceive(Timer.publish(every: timerInterval, on: .main, in: .common).autoconnect(), perform: { _ in
                        if isEnabled && animate {
                            withAnimation(.bouncy, completionCriteria: .removed) {
                                hintWidth = 8
                            } completion: {
                                withAnimation(.bouncy) {
                                    hintWidth = 0
                                }
                            }
                        }
                    })
                
                Image(systemName: "chevron.right.circle.fill")
                    .resizable()
                    .frame(width: size, height: size)
                    .foregroundStyle(.blue, .white)
                
            }
        }
        .fixedSize()
        .compositingGroup()
    }
}

#Preview {
    ZStack {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: 100, height: 100)
            .foregroundStyle(.blue)
        
        SlideToActKnob(animate: .constant(true))
    }
}
