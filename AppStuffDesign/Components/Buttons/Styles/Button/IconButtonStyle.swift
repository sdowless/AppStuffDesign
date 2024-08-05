//
//  IconButtonStyle.swift
//  AppStuffDesign
//
//  Created by Stephan Dowless on 7/2/24.
//

import SwiftUI

struct IconButtonStyle: ButtonStyle {
    @Environment(\.isLoading) var isLoading
    
    private var rank: ASDButtonRank
    private var size: ASDIconButtonSize
    private var variant: ASDButtonVariant
    
    init(rank: ASDButtonRank = .primary, size: ASDIconButtonSize = .default, variant: ASDButtonVariant = .default) {
        self.rank = rank
        self.size = size
        self.variant = variant
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .labelStyle(
                .iconButton(
                    rank: rank,
                    size: size,
                    variant: variant,
                    isPressed: configuration.isPressed
                ),
                isLoading: isLoading
            )
    }
}

extension ButtonStyle where Self == IconButtonStyle {
    static var icon: Self {
        .init()
    }
    
    static func icon(rank: ASDButtonRank = .primary, size: ASDIconButtonSize = .default, variant: ASDButtonVariant = .default) -> Self {
        .init(rank: rank, size: size, variant: variant)
    }
}
