//
//  NavigationBarBackButton.swift
//  InstagramTutorial
//
//  Created by Stephan Dowless on 3/15/24.
//

import SwiftUI

public struct NavigationBarBackButton: View {
    @Environment(\.dismiss) var dismiss
    
    public var body: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "chevron.left")
                .imageScale(.large)
        }
        .foregroundStyle(Color(.primaryText))

    }
}

#Preview {
    NavigationBarBackButton()
}
