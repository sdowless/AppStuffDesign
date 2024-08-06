//
//  View+LabelStyle.swift
//  AppStuffDesign
//
//  Created by Stephan Dowless on 7/7/24.
//

import SwiftUI

public extension View {
    func labelStyle<S: LabelStyle>(_ style: S, isLoading: Binding<Bool>) -> some View {
        self.labelStyle(style).environment(\.isLoading, isLoading)
    }
}
