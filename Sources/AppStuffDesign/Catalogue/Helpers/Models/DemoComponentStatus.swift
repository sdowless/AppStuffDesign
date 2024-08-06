//
//  DemoComponentStatus.swift
//  AppStuffDesign
//
//  Created by Stephan Dowless on 8/5/24.
//

import SwiftUI

enum DemoComponentStatus: String, SectionViewModel {
    case critical = "Critical"
    case `default` = "Default"
    case favorable = "Favorable"
    case informational = "Informational"
    case warning = "Warning"
    
    var status: ASDStatus {
        switch self {
        case .critical:
            return .critical
        case .default:
            return .default
        case .favorable:
            return .favorable
        case .informational:
            return .informational
        case .warning:
            return .warning
        }
    }
}
