//
//  ASDTextField.swift
//  AppStuffDesign
//
//  Created by Stephan Dowless on 7/3/24.
//

import SwiftUI

public struct ASDTextField: View {
    @Binding private var accessoryActionInProgress: Bool
    @Binding private var error: Error?
    @Binding private var text: String

    private var accessoryButtonAction: (() -> Void)?
    private var accessoryButtonTitle: String?
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

    public init(_ titleKey: String, text: Binding<String>, axis: Axis = .horizontal) {
        self.titleKey = titleKey
        self._text = text
        self.axis = axis
        
        self._accessoryActionInProgress = .constant(false)
        self._error = .constant(nil)
    }
        
    public var body: some View {
        VStack {
            ZStack(alignment: .trailing) {
                TextField(titleKey, text: $text, axis: axis)
                    .padding(.trailing, trailingPadding)
                    .font(.subheadline)
                    .padding(12)
                    .padding(.leading, clipShape == .capsule ? 4 : 0)
                    .background(backgroundColor)
                    .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                    .textInputAutocapitalization(autocapitlization)
                    .autocorrectionDisabled(autocorrectionDisabled)
                    .keyboardType(keyboardType)
                    .submitLabel(submitLabel)
                    .overlay {
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .strokeBorder(borderColor, style: .init(lineWidth: 1))
                    }
                
                if isLoading && error == nil {
                    ProgressView()
                        .padding(.horizontal, 16)
                }
                
                if error != nil && !hasAccessoryButton {
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
                
                if hasAccessoryButton, let accessoryButtonTitle, let accessoryButtonAction {
                    ASDButton(accessoryButtonTitle, action: accessoryButtonAction)
                        .buttonStyle(
                            .standard(rank: .tertiary, size: .medium),
                            isLoading: $accessoryActionInProgress
                        )
                        .padding(.horizontal, 12)
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

public extension ASDTextField {
    func accessoryAction(_ title: String, isLoading: Binding<Bool>? = nil, action: @escaping () -> Void) -> Self {
        var copy = self
        copy.accessoryButtonTitle = title
        copy.accessoryButtonAction = action
        copy._accessoryActionInProgress = isLoading ?? .constant(false)
        return copy
    }
        
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
        if hasAccessoryButton { return self }

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
    
    var borderColor: Color {
        switch textFieldStyle {
        case .backgroundFill:
            return .clear
        case .bordered:
            return Color(.systemGray3)
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
    
    var hasAccessoryButton: Bool {
        accessoryButtonTitle != nil && accessoryButtonAction != nil
    }
    
    var trailingPadding: CGFloat {
        return hasAccessoryButton || error != nil || isLoading ? 32 : 4
    }
}

#Preview {
    VStack(spacing: 16) {
        ASDTextField("Enter your email", text: .constant(""))
        
        ASDTextField("Enter your email", text: .constant(""))
            .loadable(.constant(true))
        
        ASDTextField("Type your comment..", text: .constant(""))
            .clipShape(.capsule)
        
        ASDTextField("Type your comment..", text: .constant(""))
            .clipShape(.capsule)
            .accessoryAction("Send", action: {})
        
        ASDTextField("Type your comment..", text: .constant(""))
            .textFieldStyle(.bordered)
    }
    .padding()
}
