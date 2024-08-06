//
//  ASDButton.swift
//  AppStuffDesign
//
//  Created by Stephan Dowless on 7/1/24.
//

import SwiftUI

public struct ASDButton: View {
    @Environment(\.isEnabled) var isEnabled
    @Environment(\.isLoading) var isLoading
    
    private var action:(() -> Void)
    private var title: String?
    private var systemImage: String?
    
    public init(_ title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }
    
    public init(_ title: String, systemImage: String, action: @escaping () -> Void) {
        self.title = title
        self.systemImage = systemImage
        self.action = action
    }
    
    public init(systemImage: String, action: @escaping () -> Void) {
        self.systemImage = systemImage
        self.action = action
    }
    
    public var body: some View {
        Label {
            if let title {
                Text(title)
            }
        } icon: {
            if let systemImage {
                Image(systemName: systemImage)
            }
        }
        .contentShape(Rectangle())
        .buttonRepresentable(enabled: isEnabled, with: action)
    }
}

#Preview {
    VStack(spacing: 16) {
        ASDButton("Primary Rank", action: {})
            .buttonStyle(.standard(rank: .primary, variant: .neutral))
        
        ASDButton("Primary Icon", systemImage: "swift", action: {})
            .buttonStyle(.standard(rank: .primary, variant: .neutral))
        
        ASDButton("Secondary Rank", action: {})
            .buttonStyle(.standard(rank: .secondary, variant: .neutral))
        
        ASDButton("Icon Secondary", systemImage: "paperplane", action: {})
            .buttonStyle(.standard(rank: .secondary, variant: .neutral))
        
        ASDButton("Tertiary Rank", action: {})
            .buttonStyle(.standard(rank: .tertiary, variant: .neutral))
        
        ASDButton("Tertiary Icon", systemImage: "swift", action: {})
            .buttonStyle(.standard(rank: .tertiary, variant: .neutral))
        
        Divider()
        
        HStack {
            ASDButton(systemImage: "swift", action: {})
                .buttonStyle(.icon(rank: .primary, size: .large, variant: .neutral))
            
            ASDButton(systemImage: "swift", action: {})
                .buttonStyle(.icon(rank: .secondary, variant: .neutral))
            
            ASDButton(systemImage: "swift", action: {})
                .buttonStyle(.icon(rank: .tertiary, variant: .neutral))
        }
    }
}
