//
//  ASDTextField.swift
//  AppStuffDesign
//
//  Created by Stephan Dowless on 7/3/24.
//

import SwiftUI

struct ASDTextField: View {
    @Binding private var error: Error?
    @Binding private var text: String
    
    private var autocapitlization: TextInputAutocapitalization = .sentences
    private var autocorrectionDisabled: Bool = false
    private var axis: Axis = .horizontal
    private var clipShape: ASDTextFieldClipShape = .roundedRect
    private var isLoading: Bool = false
    private var keyboardType: UIKeyboardType = .default
    private var returnKeyType: UIReturnKeyType = .default
    private var submitLabel: SubmitLabel = .done
    private var textFieldStyle: ASDTextFieldStyle = .backgroundFill
    private let titleKey: String

    init(_ titleKey: String, text: Binding<String>, axis: Axis = .horizontal) {
        self.titleKey = titleKey
        self._text = text
        self.axis = axis
        
        self._error = .constant(nil)
    }
        
    var body: some View {
        VStack {
            ZStack(alignment: .trailing) {
                TextField(titleKey, text: $text, axis: axis)
                    .font(.subheadline)
                    .padding(12)
                    .background(backgroundColor)
                    .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                    .frame(width: 360)
                    .textInputAutocapitalization(autocapitlization)
                    .autocorrectionDisabled(autocorrectionDisabled)
                    .keyboardType(keyboardType)
                    .submitLabel(submitLabel)
                
                if isLoading {
                    ProgressView()
                        .padding(.trailing, 16)
                }
                
                if error != nil {
                    Button {
                        text = ""
                        error = nil
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .imageScale(.large)
                            .fontWeight(.bold)
                            .foregroundColor(Color(.systemRed))
                            .padding(.trailing, 16)
                    }
                }
            }
            
            if let error {
                Text(error.localizedDescription)
                    .font(.caption)
                    .foregroundColor(Color(.systemRed))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 28)
            }
        }
    }
}

extension ASDTextField {
    func autocorrectionDisabled(_ disabled: Bool) -> Self {
        var copy = self
        copy.autocorrectionDisabled = disabled
        return copy
    }
    
    func clipShape(_ shape: ASDTextFieldClipShape) -> Self {
        var copy = self
        copy.clipShape = shape
        return copy
    }
    
    func error(error: Binding<Error?>) -> Self {
        var copy = self
        copy._error = error
        return copy
    }
    
    func keyboardType(_ type: UIKeyboardType) -> Self {
        var copy = self
        copy.keyboardType = type
        return copy
    }
    
    func loadable(_ isLoading: Binding<Bool>) -> Self {
        var copy = self
        copy.isLoading = isLoading.wrappedValue && error == nil 
        return copy
    }
    
    func submitLabel(_ label: SubmitLabel) -> Self {
        var copy = self
        copy.submitLabel = label
        return copy
    }
    
    func textInputAutocapitalization(_ autocapitalization: TextInputAutocapitalization) -> Self {
        var copy = self
        copy.autocapitlization = autocapitalization
        return copy
    }
    
    func textFieldStyle(_ style: ASDTextFieldStyle) -> Self {
        var copy = self
        copy.textFieldStyle = style
        return copy
    }
}

private extension ASDTextField {
    var backgroundColor: Color {
        switch textFieldStyle {
        case .backgroundFill:
            return Color(.systemGray6)
        case .bordered:
            return .clear
        }
    }
    
    var cornerRadius: CGFloat {
        switch clipShape {
        case .capsule:
            return 25
        case .roundedRect:
            return 10
        }
    }
}

#Preview {
    VStack(spacing: 16) {
        ASDTextField("Enter your email", text: .constant(""))
        
        ASDTextField("Enter your email", text: .constant(""))
            .loadable(.constant(true))
        
        ASDTextField("Type your comment..", text: .constant(""))
            .clipShape(.capsule)
    }
}
