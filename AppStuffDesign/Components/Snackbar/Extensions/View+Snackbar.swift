//
//  View+Snackbar.swift
//  Moment
//
//  Created by Stephan Dowless on 7/11/24.
//

import SwiftUI

extension View {
    func snackbar(
        message: String,
        systemImage: String? = nil,
        entryPosition: SnackbarEntryPosition = .bottom,
        show: Binding<Bool>
    ) -> some View {
        modifier(SnackbarModifier(message: message, systemImage: systemImage, entryPosition: entryPosition, show: show))
    }
}
