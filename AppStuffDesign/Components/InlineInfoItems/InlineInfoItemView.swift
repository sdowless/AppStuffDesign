//
//  InlineInfoItemView.swift
//  InstagramTutorial
//
//  Created by Stephan Dowless on 3/5/24.
//

import SwiftUI

struct InlineInfoItemView: View {
    private let imageName: String
    private let title: String?
    private let subtitle: String
    
    init(title: String? = nil, subtitle: String, imageName: String) {
        self.title = title
        self.subtitle = subtitle
        self.imageName = imageName
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Image(systemName: imageName)
                .frame(width: 24)
                .font(.title3)
                                
            VStack(alignment: .leading) {
                if let title {
                    Text(title)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                }
                
                Text(subtitle)
                    .foregroundStyle(title == nil ? .primary : Color(.gray))
            }
            .font(.subheadline)
            
            Spacer()
        }
    }
}

#Preview {
    VStack(spacing: 24) {
        InlineInfoItemView(
            title: "This is a title",
            subtitle: "Understand problems people are having with different types of content on AppStuffDesign.",
            imageName: "info.circle"
        )
        
        InlineInfoItemView(
            subtitle: "Understand problems people are having with different types of content on AppStuffDesign.",
            imageName: "info.circle"
        )
    }
    .padding(.horizontal, 8)
}
