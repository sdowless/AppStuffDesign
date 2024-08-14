//
//  View+Snackbar.swift
//  Moment
//
//  Created by Stephan Dowless on 7/11/24.
//

import SwiftUI

public extension View {
    func snackbar(
        message: String,
        systemImage: String? = nil,
        duration: SnackbarDuration = .d1,
        entryPosition: SnackbarEntryPosition = .bottom,
        show: Binding<Bool>,
        accessoryAction: SnackbarAction? = nil 
    ) -> some View {
        modifier(
            SnackbarModifier(
                message: message,
                systemImage: systemImage,
                duration: duration,
                entryPosition: entryPosition,
                show: show
            )
        )
    }
}
