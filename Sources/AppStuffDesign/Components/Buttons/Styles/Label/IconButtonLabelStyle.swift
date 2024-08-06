//
//  IconButtonLabelStyle.swift
//  AppStuffDesign
//
//  Created by Stephan Dowless on 7/2/24.
//

import SwiftUI

struct IconButtonLabelStyle: LabelStyle {
    @Environment(\.isLoading) var isLoading
    
    private var rank: ASDButtonRank
    private var size: ASDIconButtonSize
    private var variant: ASDButtonVariant
    private var isPressed: Bool
    
    init(rank: ASDButtonRank, size: ASDIconButtonSize = .default, variant: ASDButtonVariant, isPressed: Bool = false ) {
        self.rank = rank
        self.size = size
        self.variant = variant
        self.isPressed = isPressed
    }
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            if isLoading.wrappedValue {
                ProgressView()
                    .tint(variant.foregroundStyle(for: rank))
            } else {
                configuration.icon
                    .imageScale(imageScale)
                    .foregroundStyle(variant.foregroundStyle(for: rank))
                    .opacity(isPressed ? 0.4 : 1.0)
            }
        }
        .frame(width: size.dimension, height: size.dimension)
        .background {
            Circle()
                .fill(variant.backgroundColor(for: rank))
                .opacity(isPressed ? 0.4 : 1.0)
        }
        .overlay {
            if rank == .secondary {
                Circle()
                    .stroke(variant.borderColor, lineWidth: 1)
                    .opacity(isPressed ? 0.4 : 1.0)
            }
        }
    }
}

extension LabelStyle where Self == IconButtonLabelStyle {
    static func iconButton(rank: ASDButtonRank, size: ASDIconButtonSize = .default, variant: ASDButtonVariant, isPressed: Bool = false) -> Self {
        .init(rank: rank, size: size, variant: variant, isPressed: isPressed)
    }
}

private extension IconButtonLabelStyle {
    var imageScale: Image.Scale {
        switch size {
        case .default:
            return .medium
        case .large:
            return .large
        }
    }
    var foregroundColor: Color {
        return variant.foregroundStyle(for: rank).opacity(isPressed ? 0.4 : 1.0)
    }
    
    var backgroundColor: Color {
        return variant.backgroundColor(for: rank).opacity(isPressed ? 0.4 : 1.0)
    }
}

