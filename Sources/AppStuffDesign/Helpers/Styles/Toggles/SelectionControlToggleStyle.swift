//
//  SelectionControlToggleStyle.swift
//  AppStuffDesign
//
//  Created by Stephan Dowless on 7/7/24.
//

import SwiftUI

struct SelectionControlToggleStyle: ToggleStyle {
    
    private let placement: HorizontalAlignment
    
    init(placement: HorizontalAlignment) {
        self.placement = placement
    }
    
    func makeBody(configuration: Configuration) -> some View {
        Label {
            configuration.label
        } icon: {
            Button {
                configuration.isOn.toggle()
            } label: {
                RadioButton.Icon(isOn: configuration.isOn)
            }

        }
        .labelStyle(.selectionControl(placement: placement))
    }
}

extension ToggleStyle where Self == SelectionControlToggleStyle {
    static func radioButton(placement: HorizontalAlignment = .leading) -> SelectionControlToggleStyle {
        .init(placement: placement)
    }
}
