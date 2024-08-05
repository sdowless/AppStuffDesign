//
//  ASDButtonIconLayout.swift
//  AppStuffDesign
//
//  Created by Stephan Dowless on 7/6/24.
//

import Foundation

enum ASDButtonIconLayout {
    /// Adds a trailing chevron icon.
    ///
    /// > Important: A chevron will only be added if the button's rank is ``LSButtonRank/tertiary``.
    case chevron
    
    /// Adds the icon to the left of the button's title.
    case leading
    
    /// Adds the icon to the right of the button's title
    case trailing
}
