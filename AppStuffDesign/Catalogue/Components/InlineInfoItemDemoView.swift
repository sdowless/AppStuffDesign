//
//  InlineInfoItemDemoView.swift
//  AppStuffDesign
//
//  Created by Stephan Dowless on 8/5/24.
//

import SwiftUI

struct InlineInfoItemDemoView: View {
    @State private var title: String? = "This is a title"
    @State private var subtitle = "This is a subtitle for the inline info item view"
    @State private var imageName = "info.circle"
    @State private var showTitle = true
    @State private var iconAlignment: IconAlignment = .center
    
    var body: some View {
        VStack {
            VStack {
                InlineInfoItemView(
                    title: showTitle ? title : nil,
                    subtitle: subtitle,
                    imageName: "info.circle"
                )         
                .iconAlignment(iconAlignment.alignment)
                .padding(.horizontal, 8)
            }
            .frame(height: 140)
            
            List {
                Section("Title") {
                    Toggle("Show Title", isOn: $showTitle)
                        .tint(.blue)
                }
                
                Section("Subtitle") {
                    TextField("Subtitle", text: $subtitle, axis: .vertical)
                }
                
                DemoOptionSection("Icon Alignment", options: IconAlignment.allCases, selectedItem: $iconAlignment)
            }
        }
        .navigationTitle("Inline Info Item")
        .navigationBarTitleDisplayMode(.inline)
    }
}

private extension InlineInfoItemDemoView {
    enum IconAlignment: String, SectionViewModel {
        case top = "Top"
        case center = "Center"
        
        var alignment: VerticalAlignment {
            switch self {
            case .top:
                return .top
            case .center:
                return .center
            }
        }
    }
}

#Preview {
    InlineInfoItemDemoView()
}
