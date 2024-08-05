//
//  InlineAlertView.swift
//  AppStuffDesign
//
//  Created by Stephan Dowless on 7/6/24.
//

import SwiftUI

struct InlineAlertView: View {
    @State private var isDismissed = false
    @State private var opacity: CGFloat = 1.0
    
    @Binding private var isPresented: Bool
    
    private var accessoryButtonAction: (() -> Void)?
    private var accessoryButtonTitle: String?
    private var isDismissable = false
    private var message: String
    private var title: String?
    private var status: ASDStatus = .default
    private var systemImage: String?
    private var variant: InlineAlertVariant = .status(.default)
    
    init(_ title: String? = nil, message: String, systemImage: String? = nil) {
        _isPresented = .constant(true)
        
        self.title = title
        self.message = message
        self.systemImage = systemImage
    }
    
    init(
        _ title: String? = nil,
        message: String,
        systemImage: String? = nil,
        isPresented: Binding<Bool>,
        isDismissable: Bool = false
    ) {
        self.title = title
        self.message = message
        self.systemImage = systemImage
        self.isDismissable = isDismissable
        _isPresented = isPresented
    }
    
    var body: some View {
        Group {
            if isPresented {
                Label {
                    HStack(alignment: .top, spacing: 0) {
                        VStack(alignment: .leading, spacing: 4) {
                            if let title {
                                Text(title)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                            }
                            
                            Text(message)
                                .font(.subheadline)
                            
                            if let accessoryButtonTitle, let accessoryButtonAction {
                                ASDButton(accessoryButtonTitle, action: accessoryButtonAction)
                                    .buttonStyle(
                                        .standard(
                                            rank: .tertiary,
                                            size: .small,
                                            variant: .neutral,
                                            iconLayout: .chevron
                                        )
                                    )
                                    .padding(.top, 4)
                            }
                        }
                        
                        Spacer()
                        
                        if isDismissable {
                            Button {
                                withAnimation(.bouncy) { isPresented = false }
                            } label: {
                                Image(systemName: "xmark")
                                    .imageScale(.small)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(Color(.primaryText))
                            }
                        }
                    }
                } icon: {
                    if let systemImage {
                        Image(systemName: systemImage)
                            .font(.headline)
                            .foregroundStyle(iconColor)
                    }
                }
                .animation(.bouncy, value: isPresented)
                .padding(.horizontal, 16)
                .padding(.top, 14)
                .padding(.bottom, hasAccessoryButton ? 10 : 14)
                .background(backgroundColor)
                .clipShape(.rect(cornerRadius: 6))
                .padding(.horizontal)
            }
        }
    }
}

extension InlineAlertView {
    func accessoryAction(_ title: String, action: @escaping () -> Void) -> Self {
        var copy = self
        copy.accessoryButtonTitle = title
        copy.accessoryButtonAction = action
        return copy
    }
    
    func variant(_ variant: InlineAlertVariant) -> Self {
        var copy = self
        copy.variant = variant
        return copy
    }
}

private extension InlineAlertView {
    var backgroundColor: Color {
        switch variant {
        case .onImage:
            return .primary
        case .status(let status):
            switch status {
            case .critical:
                return Color(.backgroundRedLight)
            case .default:
                return Color(.secondarySystemBackground)
            case .favorable:
                return Color(.backgroundGreenLight)
            case .informational:
                return Color(.backgroundBlueLight)
            case .warning:
                return Color(.backgroundYellowLight)
            }
        }
    }
    
    var iconColor: Color {
        switch variant {
        case .onImage:
            return .primary
        case .status(let status):
            switch status {
            case .critical:
                return .red
            case .default:
                return Color(.primaryText)
            case .favorable:
                return Color(.systemGreen)
            case .informational:
                return Color(.systemBlue)
            case .warning:
                return Color(.systemYellow)
            }
        }
    }
}

private extension InlineAlertView {
    var hasAccessoryButton: Bool {
        accessoryButtonTitle != nil && accessoryButtonAction != nil
    }
}

#Preview {
    VStack {
        InlineAlertView(
            "This is a title",
            message: "This is a message for the inline alert stuff. This message is more than one line",
            systemImage: "dollarsign.circle.fill"
        )
        .accessoryAction("Accessory action", action: {})
        
        InlineAlertView(
            "This is a title",
            message: "This is a message for the inline alert stuff. This message is more than one line",
            systemImage: "dollarsign.circle.fill"
        )
        .variant(.status(.informational))
        
        InlineAlertView(
            "This is a title",
            message: "This is a message for the inline alert stuff. This message is more than one line",
            systemImage: "dollarsign.circle.fill"
        )
        .variant(.status(.critical))
        
        InlineAlertView(
            "This is a title",
            message: "This is a message for the inline alert stuff. This message is more than one line",
            systemImage: "dollarsign.circle.fill"
        )
        .variant(.status(.favorable))
        
        InlineAlertView(
            "This is a title",
            message: "This is a message for the inline alert stuff. This message is more than one line",
            systemImage: "dollarsign.circle.fill"
        )
        .variant(.status(.warning))
    }
}
