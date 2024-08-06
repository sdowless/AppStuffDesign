//
//  RadioButtonDemoView.swift
//  AppStuffDesign
//
//  Created by Stephan Dowless on 8/5/24.
//

import SwiftUI

struct RadioButtonDemoView: View {
    @State private var title: String? = "Enable Auto-Pay"
    @State private var isOn = false
    @State private var showTitle = true
    @State private var controlPlacement: IconAlignment = .leading
    
    var body: some View {
        VStack {
            VStack {
                RadioButton(showTitle ? title : nil, isOn: $isOn)
                    .selectionControlPlacement(controlPlacement.value)
                    .padding(.horizontal)
            }
            .frame(height: 140)
            
            List {
                Section("Title") {
                    Toggle("Show Title", isOn: $showTitle)
                        .tint(.blue)
                }
                
                DemoOptionSection(
                    "Control Placement",
                    options: IconAlignment.allCases,
                    selectedItem: $controlPlacement
                )
            }
        }
    }
}

private extension RadioButtonDemoView {
    enum IconAlignment: String, SectionViewModel {
        case leading = "Leading"
        case trailing = "Trailing"
        
        var value: HorizontalAlignment {
            switch self {
            case .leading:
                return .leading
            case .trailing:
                return .trailing
            }
        }
    }
}

#Preview {
    RadioButtonDemoView()
}
