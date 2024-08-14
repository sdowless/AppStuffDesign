//
//  SnackbarAction.swift
//  Moment
//
//  Created by Stephan Dowless on 7/11/24.
//

import Foundation

public struct SnackbarAction: Identifiable {
    let id: UUID = .init()
    
    var title: String
    var handler: () -> Void
    
    init(title: String, handler: @escaping () -> Void) {
        self.title = title
        self.handler = handler
    }
}

extension SnackbarAction: Equatable {
    static func == (lhs: SnackbarAction, rhs: SnackbarAction) -> Bool {
        return lhs.id == rhs.id && lhs.title == rhs.title
    }
}
