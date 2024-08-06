//
//  Dropdown.swift
//  AppStuffDesign
//
//  Created by Stephan Dowless on 7/7/24.
//

import SwiftUI

public struct Dropdown<Selection: CustomStringConvertible>: View {
    @Binding private var selection: Selection?
    
    private let title: String?
    private let helperText: String? = nil
    private var errorMessage: String? = nil
    private var showError = false
        
    public init(_ title: String?, selection: Binding<Selection?>) {
        _selection = selection
        
        self.title = title
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            if let title {
                Text(title)
                    .font(.subheadline)
            }
            
            ZStack {
                RoundedRectangle(cornerRadius: 6)
                    .strokeBorder(Color(showError ? Color(.systemRed) : Color(.primaryText)), lineWidth: 1)
                    .frame(height: 48)
                
                HStack(spacing: 8) {
                    if let selection {
                        Text(selection.description)
                            .font(.subheadline)
                            .foregroundStyle(Color(.primaryText))
                            .truncationMode(.tail)
                            .lineLimit(1)
                    }
                    
                    Spacer()
                    
                    Image(systemName: "chevron.down")
                        .foregroundStyle(Color(.primaryText))
                }
                .padding(.horizontal)
            }
            .contentShape(Rectangle())
            
            if showError, let errorMessage {
                Text(errorMessage)
                    .foregroundStyle(.red)
                    .font(.subheadline)
            }
        }
    }
}

public extension Dropdown {
    func alertable(_ showError: Bool, message: String) -> Self {
        var copy = self
        copy.showError = showError
        copy.errorMessage = message
        return copy
    }
}

#Preview {
    Dropdown(
        "Payment Frequency",
        selection: .constant("Monthly")
    )
    .alertable(true, message: "Please select a payment frequency")
    .padding()
}
