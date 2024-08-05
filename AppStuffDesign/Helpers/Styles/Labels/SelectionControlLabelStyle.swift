//
//  SelectionControlLabelStyle.swift
//  AppStuffDesign
//
//  Created by Stephan Dowless on 7/8/24.
//

import SwiftUI

struct SelectionControlLabelStyle: LabelStyle {
    private let placement: HorizontalAlignment
    
    init(placement: HorizontalAlignment) {
        self.placement = placement
    }
    
    func makeBody(configuration: Configuration) -> some View {
        switch placement {
        case .leading:
            HStack {
                configuration.icon
                configuration.title
            }
        case .trailing:
            HStack {
                configuration.title
                Spacer()
                configuration.icon
            }
        default:
            EmptyView()
        }
    }
}

extension LabelStyle where Self == SelectionControlLabelStyle {
    static func selectionControl(placement: HorizontalAlignment = .leading) -> SelectionControlLabelStyle {
        .init(placement: placement)
    }
}
