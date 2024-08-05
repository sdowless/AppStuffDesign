//
//  ButtonTransformer.swift
//  AppStuffDesign
//
//  Created by Stephan Dowless on 7/2/24.
//

import SwiftUI

private struct ButtonTransformer: ViewModifier {
    var enabled: Bool
    var action: () -> Void
    
    func body(content: Content) -> some View {
        Button(action: action) {
            content
        }
        .disabled(!enabled)
        .opacity(enabled ? 1.0 : 0.5)
    }
}

extension View {
    func buttonRepresentable(enabled: Bool = true, with action: @escaping () -> Void) -> some View {
        modifier(ButtonTransformer(enabled: enabled, action: action))
    }
}
