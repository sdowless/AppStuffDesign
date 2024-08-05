//
//  CircularProfileImageView.swift
//  InstagramTutorial
//
//  Created by Stephan Dowless on 5/9/23.
//

import SwiftUI
import Kingfisher

struct AvatarView: View {
    private let imageUrl: String?
    private let size: AvatarSize
    
    private var avatarClipShape: AvatarClipShape = .circle
    
    init(imageUrl: String?, size: AvatarSize) {
        self.imageUrl = imageUrl
        self.size = size
    }
    
    var body: some View {
        if let imageUrl {
            KFImage(URL(string: imageUrl))
                .resizable()
                .scaledToFill()
                .frame(width: size.dimension, height: size.dimension)
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        } else {
            Image(systemName: placeholderImageName)
                .resizable()
                .scaledToFill()
                .frame(width: size.dimension, height: size.dimension)
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                .foregroundColor(Color(.systemGray4))
        }
    }
}

extension AvatarView {
    func clipShape(_ avatarClipShape: AvatarClipShape) -> Self {
        var copy = self
        copy.avatarClipShape = avatarClipShape
        return copy
    }
}

private extension AvatarView {
    var placeholderImageName: String {
        switch avatarClipShape {
        case .circle:
            return "person.circle.fill"
        case .roundedRect:
            return "person.crop.square.fill"
        }
    }
    
    var cornerRadius: CGFloat {
        switch avatarClipShape {
        case .circle:
            return size.dimension / 2
        case .roundedRect:
            return 10
        }
    }
}

#Preview {
    Group {
        AvatarView(imageUrl: nil, size: .medium)
            .clipShape(.roundedRect)
        
        AvatarView(imageUrl: nil, size: .medium)
    }
}
