//
//  Snackbar.swift
//  Moment
//
//  Created by Stephan Dowless on 7/10/24.
//

import SwiftUI

public struct Snackbar: View {
    @Binding private var isPresented: Bool
    
    private let accessoryAction: SnackbarAction?
    private let duration: SnackbarDuration
    private let message: String
    private let systemImage: String?
    
    public init(
        message: String,
        systemImage: String? = nil,
        duration: SnackbarDuration = .d1,
        isPresented: Binding<Bool>,
        accessoryAction: SnackbarAction? = nil
    ) {
        _isPresented = isPresented
        self.message = message
        self.systemImage = systemImage
        self.duration = duration
        self.accessoryAction = accessoryAction
    }
    
    public var body: some View {
        if isPresented {
            HStack(spacing: 12) {
                Label {
                    Text(message)
                        .font(.subheadline)
                } icon: {
                    if let systemImage {
                        Image(systemName: systemImage)
                    }
                }
                
                Spacer()
                
                Button(accessoryAction?.title ?? "Dismiss") {
                    dismiss(onCompletion: accessoryAction?.handler)
                }
                .font(.subheadline)
                .fontWeight(.semibold)
            }
            .contentShape(.rect)
            .frame(width: 320)
            .fixedSize(horizontal: true, vertical: true)
            .padding(.vertical, 18)
            .padding(.horizontal)
            .foregroundStyle(Color(.primaryTextInverse))
            .background(.primary)
            .clipShape(.rect(cornerRadius: 6))
            .onTapGesture { dismiss() }
            .task { await autoDismiss() }
        }
    }
}

private extension Snackbar {
    func dismiss(onCompletion handler: (() -> Void)? = nil) {
        isPresented.toggle()
    }
    
    func autoDismiss() async {
        try? await Task.sleep(nanoseconds: UInt64((duration.rawValue)) * 1_000_000_000)
        if isPresented { dismiss() }
    }
}

#Preview {
    Snackbar(message: "No internet connection.", isPresented: .constant(true))
}
