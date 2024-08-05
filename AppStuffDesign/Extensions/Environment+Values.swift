//
//  Environment+Values.swift
//  AppStuffDesign
//
//  Created by Stephan Dowless on 7/7/24.
//

import SwiftUI

private struct LoadingKey: EnvironmentKey {
    static let defaultValue: Binding<Bool> = .constant(false)
}

extension EnvironmentValues {
    var isLoading: Binding<Bool> {
        get { self[LoadingKey.self] }
        set { self[LoadingKey.self] = newValue }
    }
}
