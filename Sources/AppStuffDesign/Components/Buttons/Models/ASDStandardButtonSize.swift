//
//  ASDStandardButtonSize.swift
//  AppStuffDesign
//
//  Created by Stephan Dowless on 7/1/24.
//

import Foundation

public enum ASDStandardButtonSize {
    /// Returns a standard button with dimensions of 86x32
    case compact
    
    /// Returns a standard button with dimensions of 100x32
    case small
    
    /// Returns a standard button with dimensions of 360x32
    case medium
    
    /// Returns a standard button with dimensions of 360x48
    case large
    
    /// Returns a standard button with custom dimensions
    case custom(CGSize)
    
    var dimension: CGSize {
        switch self {
        case .small:
            return .init(width: 100, height: 32)
        case .medium:
            return .init(width: 360, height: 32)
        case .large:
            return .init(width: 360, height: 48)
        case .compact:
            return .init(width: 86, height: 32)
        case .custom(let size):
            return size
        }
    }
}
