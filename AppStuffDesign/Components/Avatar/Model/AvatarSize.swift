//
//  AvatarSize.swift
//  InstagramTutorial
//
//  Created by Stephan Dowless on 3/1/24.
//

import Foundation

enum AvatarSize {
    /// An avatar size of 40x40
    case xSmall
    
    /// An avatar size of 48x48
    case small
    
    /// An avatar size of 60x60
    case medium
    
    /// An avatar size of 80x80
    case large
    
    /// An avatar size of 96x96
    case xLarge
    
    var dimension: CGFloat {
        switch self {
        case .xSmall:
            return 40
        case .small:
            return 48
        case .medium:
            return 60
        case .large:
            return 80
        case .xLarge:
            return 96
        }
    }
}
