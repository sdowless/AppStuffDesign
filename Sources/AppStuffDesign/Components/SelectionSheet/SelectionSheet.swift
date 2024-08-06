//
//  SelectionSheet.swift
//  AppStuffDesign
//
//  Created by Stephan Dowless on 8/2/24.
//

import SwiftUI

public protocol SelectionProtocol: CustomStringConvertible, Hashable { }

public struct SelectionSheet<T: SelectionProtocol>: View {
    @Environment(\.dismiss) var dismiss
    
    let title: String
    let options: [T]
    
    @Binding var selection: T?
    
    public init(_ title: String, options: [T], selection: Binding<T?>) {
        _selection = selection
        
        self.title = title
        self.options = options
    }
    
    public var body: some View {
        VStack {
            Text(title)
                .font(.headline)
                .padding()
            
            ForEach(options, id: \.self) { option in
                VStack {
                    RadioButton(
                        option.description,
                        item: option,
                        selectedItem: $selection
                    )
                    .selectionControlPlacement(.trailing)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    
                    Divider()
                }
                .frame(height: 44)
            }
            
            Spacer()
        }
        .onChange(of: selection) { oldValue, newValue in
            if newValue != nil {
                dismiss()
            }
        }
    }
}

#Preview {
    SelectionSheet(
        "Payment Options",
        options: PaymentOptions.allCases,
        selection: .constant( PaymentOptions.monthly)
    )
}
