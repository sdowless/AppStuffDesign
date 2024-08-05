//
//  ASDTextFieldModifer.swift
//  Moment
//
//  Created by Stephan Dowless on 7/15/24.
//

import SwiftUI

struct ASDTextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .padding(12)
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .frame(width: 360)
    }
}
