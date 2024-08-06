//
//  SnackbarModifier.swift
//  Moment
//
//  Created by Stephan Dowless on 7/11/24.
//

import SwiftUI

public struct SnackbarModifier: ViewModifier {
    @Binding var show: Bool
        
    private let message: String
    private let entryPosition: SnackbarEntryPosition
    private let systemImage: String?
    private let duration: SnackbarDuration
    private let action: SnackbarAction?
    
    public init(
        message: String,
        systemImage: String? = nil,
        duration: SnackbarDuration = .d1,
        entryPosition: SnackbarEntryPosition = .bottom,
        show: Binding<Bool>,
        accessoryAction: SnackbarAction? = nil
    ) {
        _show = show
        
        self.message = message
        self.systemImage = systemImage
        self.duration = duration
        self.entryPosition = entryPosition
        self.action = accessoryAction
    }
    
    public func body(content: Content) -> some View {
        ZStack {
            content

            if show {
                VStack {
                    switch entryPosition {
                    case .bottom:
                        Spacer()
                        snackbar
                    case .top:
                        snackbar
                        Spacer()
                    }
                }
                .frame(maxWidth: .infinity)
                .transition(.move(edge: transitionEdge))
            }
        }
        .animation(.bouncy(duration: 0.3), value: show)
    }
}

private extension SnackbarModifier {
    var snackbar: some View {
        Snackbar(
            message: message,
            systemImage: systemImage,
            duration: duration,
            isPresented: $show,
            accessoryAction: action
        )
    }
    
    
    var transitionEdge: Edge {
        switch entryPosition {
        case .bottom:
            return .bottom
        case .top:
            return .top
        }
    }
}
