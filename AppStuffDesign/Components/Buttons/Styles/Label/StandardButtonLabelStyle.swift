//
//  StandardButtonLabelStyle.swift
//  AppStuffDesign
//
//  Created by Stephan Dowless on 7/2/24.
//

import SwiftUI

struct StandardButtonLabelStyle: LabelStyle {
    @Environment(\.isLoading) var isLoading
    
    private var rank: ASDButtonRank
    private var size: ASDStandardButtonSize
    private var variant: ASDButtonVariant
    private var iconLayout: ASDButtonIconLayout
    private var isPressed: Bool
    
    init(
        rank: ASDButtonRank,
        size: ASDStandardButtonSize = .large,
        variant: ASDButtonVariant,
        iconLayout: ASDButtonIconLayout = .leading,
        isPressed: Bool = false
    ) {
        self.rank = rank
        self.size = size
        self.variant = variant
        self.iconLayout = iconLayout
        self.isPressed = isPressed
    }
    
    func makeBody(configuration: Self.Configuration) -> some View {
        ZStack {
            if isLoading.wrappedValue {
                ProgressView()
                    .tint(variant.foregroundStyle(for: rank))
            } else {
                Group {
                    switch iconLayout {
                    case .chevron:
                        HStack(spacing: iconSpacing) {
                            configuration.title
                            
                            Image(systemName: "chevron.right")
                                .imageScale(.small)
                        }
                    case .leading:
                        HStack(spacing: iconSpacing) {
                            configuration.icon
                                .imageScale(imageScale)
                            
                            configuration.title
                        }
                    case .trailing:
                        HStack(spacing: iconSpacing) {
                            configuration.title
                            
                            configuration.icon
                                .imageScale(imageScale)
                        }
                    }
                }
                .font(font)
                .fontWeight(fontWeight)
                .fontWeight(.semibold)
            }
        }
        .frame(width: width, height: height)
        .foregroundStyle(foregroundColor)
        .background(backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 6))
        .disabled(isLoading.wrappedValue)
        .overlay {
            if rank == .secondary {
                RoundedRectangle(cornerRadius: 6)
                    .stroke(variant.borderColor, lineWidth: 1)
                    .opacity(isPressed ? 0.4 : 1.0)
            }
        }
    }
}

extension LabelStyle where Self == StandardButtonLabelStyle {
    static func standardButton(
        rank: ASDButtonRank = .primary,
        size: ASDStandardButtonSize = .large,
        variant: ASDButtonVariant = .neutral,
        iconLayout: ASDButtonIconLayout = .leading,
        isPressed: Bool = false
    ) -> Self {
        return StandardButtonLabelStyle(
            rank: rank,
            size: size,
            variant: variant,
            iconLayout: iconLayout,
            isPressed: isPressed
        )
    }
}

private extension StandardButtonLabelStyle {
    var foregroundColor: Color {
        return variant.foregroundStyle(for: rank).opacity(isPressed ? 0.4 : 1.0)
    }
    
    var backgroundColor: Color {
        return variant.backgroundColor(for: rank).opacity(isPressed ? 0.4 : 1.0)
    }
    
    var font: Font {
        switch size {
        case .small, .medium, .compact, .custom:
            return .subheadline
        case .large:
            return .headline
        }
    }
    
    var fontWeight: Font.Weight {
        if rank == .tertiary {
            return .semibold
        } else {
            switch size {
            case .small:
                return .regular
            case .medium, .large, .compact, .custom:
                return .semibold
            }
        }
    }
    
    var iconSpacing: CGFloat {
        switch size {
        case .small, .compact, .custom:
            return 2
        case .medium, .large:
            return 4
        }
    }
    
    var imageScale: Image.Scale {
        switch size {
        case .small, .compact:
            return .small
        case .medium, .large, .custom:
            return .medium
        }
    }
    
    var width: CGFloat? {
        switch rank {
        case .primary, .secondary:
            return size.dimension.width
        default:
            return nil
        }
    }
    
    var height: CGFloat? {
        switch rank {
        case .primary, .secondary:
            return size.dimension.height
        default:
            return nil
        }
    }
}
