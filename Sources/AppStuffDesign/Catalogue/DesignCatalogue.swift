//
//  DesignCatalogue.swift
//  AppStuffDesign
//
//  Created by Stephan Dowless on 8/4/24.
//

import SwiftUI

struct DesignCatalogue: View {
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(filteredComponents, id: \.self) { component in
                    NavigationLink(value: component) {
                        Text(component.rawValue)
                    }
                }
            }
            .searchable(text: $searchText, prompt: "Search...")
            .navigationTitle("Design Catalogue")
            .navigationDestination(for: Components.self) { component in
                switch component {
                case .avatar:
                    AvatarDemoView()
                case .button:
                    ButtonDemoView() 
                case .dotIndicator:
                    DotIndicatorDemoView()
                case .dropdown:
                    DropdownDemoView()
                case .inlineAlert:
                    InlineAlertDemoView()
                case .inlineInfoItem:
                    InlineInfoItemDemoView()
                case .radioButton:
                    RadioButtonDemoView()
                case .slideToAct:
                    SlideToActDemoView()
                case .snackBar:
                    SnackbarDemoView()
                case .textInput:
                    TextInputDemoView()
                }
            }
        }
    }
}

private extension DesignCatalogue {
    var filteredComponents: [Components] {
        if searchText.isEmpty {
            return Components.allCases
        } else {
            return Components.allCases.filter { $0.rawValue.contains(searchText) }
        }
    }
}

private extension DesignCatalogue {
    enum Components: String, CaseIterable, Hashable {
        case avatar = "Avatar"
        case button = "Button"
        case dotIndicator = "Dot Indicator"
        case dropdown = "Dropdown"
        case inlineAlert = "Inline Alert"
        case inlineInfoItem = "Inline Info Item"
        case radioButton = "Radio Button"
        case slideToAct = "Slide To Act Button"
        case snackBar = "Snackbar"
        case textInput = "Text Input"
    }
}

#Preview {
    DesignCatalogue()
}
