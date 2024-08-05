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
    var body: some View {
        VStack {
            VStack {
                InlineInfoItemView(
                    title: title,
                    subtitle: subtitle,
                    imageName: "info.circle"
                )         
            }
            
            List {
                
            }
        }
    }
}

#Preview {
    InlineInfoItemDemoView()
}
