//
//  AvatarDemoView.swift
//  AppStuffDesign
//
//  Created by Stephan Dowless on 8/4/24.
//

import SwiftUI

struct AvatarDemoView: View {
    @State private var clipShapeOption: ClipShapeOption = .circle
    @State private var sizeOption: SizeOption = .medium
    
    var body: some View {
        VStack {
            VStack {
                AvatarView(imageUrl: nil, size: sizeOption.size)
                    .clipShape(clipShapeOption.clipShape)
            }
            .frame(height: 120)
            
            List {
                DemoOptionSection("Clip Shape", options: ClipShapeOption.allCases, selectedItem: $clipShapeOption)
                
                DemoOptionSection("Sizing", options: SizeOption.allCases, selectedItem: $sizeOption)
            }
        }
        .navigationTitle("Avatar")
        .navigationBarTitleDisplayMode(.inline)
    }
}

private extension AvatarDemoView {
    enum ClipShapeOption: String, SectionViewModel {
        case circle = "Circle"
        case roundedRect = "Rounded Rect"
        
        var clipShape: AvatarClipShape {
            switch self {
            case .circle:
                return .circle
            case .roundedRect:
                return .roundedRect
            }
        }
    }
    
    enum SizeOption: String, SectionViewModel {
        case xSmall = "Extra Small"
        case small = "Small"
        case medium = "Medium"
        case large = "Large"
        case xLarge = "Extra Large"
        
        var size: AvatarSize {
            switch self {
            case .xSmall:
                return .xSmall
            case .small:
                return .small
            case .medium:
                return .medium
            case .large:
                return .large
            case .xLarge:
                return .xLarge
            }
        }
    }
}

#Preview {
    AvatarDemoView()
}
