//
//  ASDIconButtonSize.swift
//  AppStuffDesign
//
//  Created by Stephan Dowless on 7/2/24.
//

import Foundation

public enum ASDIconButtonSize {
    /// Default icon size of 40x40
    case `default`
    
    /// Large icon size of 48x48
    case large
    
    var dimension: CGFloat {
        switch self {
        case .default:
            return 40
        case .large:
            return 48
        }
    }
}
