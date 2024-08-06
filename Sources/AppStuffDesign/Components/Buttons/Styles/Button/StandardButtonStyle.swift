//
//  StandardButtonStyle.swift
//  AppStuffDesign
//
//  Created by Stephan Dowless on 7/1/24.
//

import SwiftUI

public struct StandardButtonStyle: ButtonStyle {
    @Environment(\.isLoading) var isLoading
    
    private var rank: ASDButtonRank
    private var size: ASDStandardButtonSize
    private var variant: ASDButtonVariant
    private var iconLayout: ASDButtonIconLayout
    
    init(rank: ASDButtonRank, size: ASDStandardButtonSize = .large, variant: ASDButtonVariant, iconLayout: ASDButtonIconLayout = .leading) {
        self.rank = rank
        self.size = size
        self.variant = variant
        self.iconLayout = iconLayout
    }
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .labelStyle(
                .standardButton(
                    rank: rank,
                    size: size,
                    variant: variant,
                    iconLayout: iconLayout,
                    isPressed: configuration.isPressed
                ),
                isLoading: isLoading
            )
    }
}

public extension ButtonStyle where Self == StandardButtonStyle {
    static func standard() -> Self {
        .init(rank: .primary, variant: .default)
    }
    
    static func standard(
        rank: ASDButtonRank = .primary,
        size: ASDStandardButtonSize = .large,
        variant: ASDButtonVariant = .default,
        iconLayout: ASDButtonIconLayout = .leading
    ) -> Self {
        .init(rank: rank, size: size, variant: variant, iconLayout: iconLayout)
    }
}
