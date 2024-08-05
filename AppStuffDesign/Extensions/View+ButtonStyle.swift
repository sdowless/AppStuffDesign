//
//  View+ButtonStyle.swift
//  AppStuffDesign
//
//  Created by Stephan Dowless on 7/7/24.
//

import SwiftUI

extension View {
    func buttonStyle<S: ButtonStyle>(_ style: S, isLoading: Binding<Bool>) -> some View {
        self.buttonStyle(style).environment(\.isLoading, isLoading)
    }
}
