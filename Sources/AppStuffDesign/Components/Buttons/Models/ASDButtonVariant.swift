//
//  ASDButtonVariant.swift
//  AppStuffDesign
//
//  Created by Stephan Dowless on 7/1/24.
//

import SwiftUI

public enum ASDButtonVariant {
    case critical
    case `default`
    case neutral
    case onImage
}

extension ASDButtonVariant {
    var borderColor: Color {
        switch self {
        case .critical:
            return .red
        case .default:
            return .blue
        case .neutral:
            return .secondary
        case .onImage:
            return Color(.primaryText)
        }
    }
    
    func backgroundColor(for rank: ASDButtonRank) -> Color {
        switch rank {
        case .primary:
            switch self {
            case .critical:
                return .red
            case .default:
                return .blue
            case .neutral:
                return Color(.primaryText)
            case .onImage:
                return Color(.primaryTextInverse)
            }
        case .secondary:
            return Color(.primaryTextInverse)
        case .tertiary:
            return .clear
        }
    }
    
    func foregroundStyle(for rank: ASDButtonRank) -> Color {
        switch rank {
        case .primary:
            switch self {
            case .critical, .default:
                return .white
            case .neutral:
                return Color(.primaryTextInverse)
            case .onImage:
                return Color(.primaryText)
            }
        case .secondary, .tertiary:
            switch self {
            case .default:
                return .blue
            case .critical:
                return .red
            case .neutral, .onImage:
                return Color(.primaryText)
            }
        }
    }
    
    var textColor: Color {
        switch self {
        case .critical, .default:
            return .white
        case .neutral, .onImage:
            return Color(.primaryTextInverse)
        }
    }
}
