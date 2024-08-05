//
//  RadioButton.swift
//  AppStuffDesign
//
//  Created by Stephan Dowless on 7/7/24.
//

import SwiftUI

struct RadioButton: View {
    @Binding private var isOn: Bool
        
    private var title: String? = nil
    private var subtitle: String? = nil
    private var placement: HorizontalAlignment = .leading
        
    var body: some View {
        Toggle(isOn: $isOn) {
            if let title {
                Text(title)
                    .font(.subheadline)
                    .foregroundStyle(Color(.primaryText))
            }
        }
        .toggleStyle(.radioButton(placement: placement))
    }
}

extension RadioButton {
    struct Icon: View {
        var isOn: Bool
        
        var body: some View {
            HStack {
                ZStack {
                    Circle()
                        .strokeBorder(.blue, lineWidth: 2)
                        .frame(width: 20, height: 20)
                    
                    if isOn {
                        Circle()
                            .frame(width: 10, height: 10)
                            .foregroundStyle(.blue)
                    }
                }
                .frame(width: 24, height: 24)
                .compositingGroup()
            }
        }
    }
}

extension RadioButton {
    func selectionControlPlacement(_ placement: HorizontalAlignment) -> Self {
        var copy = self
        copy.placement = placement
        return copy 
    }
}

extension RadioButton {
    init(_ title: String? = nil, isOn: Binding<Bool>) {
        _isOn = isOn
        self.title = title
    }
    
    init(isOn: Binding<Bool>) {
        _isOn = isOn
    }
    
    init<T: Equatable>(_ title: String? = nil, item: T, selectedItem: Binding<T>?) {
        let isOnBinding = Binding {
            item == selectedItem?.wrappedValue
        } set: { _ in
            selectedItem?.wrappedValue = item
        }
                
        self.init(title, isOn: isOnBinding)
    }
}

#Preview {
    VStack(spacing: 8) {
        RadioButton("Selected", isOn: .constant(true))
        RadioButton("Not selected", isOn: .constant(false))

    }
}
