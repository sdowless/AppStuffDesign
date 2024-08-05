//
//  SnackbarModifier.swift
//  Moment
//
//  Created by Stephan Dowless on 7/11/24.
//

import SwiftUI

struct SnackbarModifier: ViewModifier {
    @Binding var show: Bool
        
    private let message: String
    private let entryPosition: SnackbarEntryPosition
    private let systemImage: String?
    
    init(
        message: String,
        systemImage: String? = nil,
        entryPosition: SnackbarEntryPosition = .bottom,
        show: Binding<Bool>
    ) {
        _show = show
        
        self.message = message
        self.systemImage = systemImage
        self.entryPosition = entryPosition
    }
    
    func body(content: Content) -> some View {
        ZStack {
            content

            if show {
                VStack {
                    switch entryPosition {
                    case .bottom:
                        Spacer()
                        Snackbar(message: message, systemImage: systemImage, isPresented: $show)
                    case .top:
                        Snackbar(message: message, systemImage: systemImage, isPresented: $show)
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
    var transitionEdge: Edge {
        switch entryPosition {
        case .bottom:
            return .bottom
        case .top:
            return .top
        }
    }
}
