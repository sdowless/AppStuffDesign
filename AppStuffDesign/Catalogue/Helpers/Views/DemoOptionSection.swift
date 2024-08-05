//
//  DemoOptionSection.swift
//  AppStuffDesign
//
//  Created by Stephan Dowless on 8/5/24.
//

import SwiftUI

protocol SectionViewModel: Hashable, RawRepresentable, CaseIterable { }

struct DemoOptionSection<T: SectionViewModel>: View {
    @Binding private var selectedItem: T

    private let title: String
    private let options: [T]
    
    init(_ title: String, options: [T], selectedItem: Binding<T>) {
        _selectedItem = selectedItem
        
        self.title = title
        self.options = options
    }
    
    var body: some View {
        Section(title) {
            ForEach(options, id: \.self) { option in
                RadioButton(option.rawValue as? String, item: option, selectedItem: $selectedItem)
                    .selectionControlPlacement(.trailing)
            }
        }
    }
}
