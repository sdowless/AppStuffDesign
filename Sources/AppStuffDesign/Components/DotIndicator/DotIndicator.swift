//
//  DotIndicator.swift
//  LiveSycle
//
//  Created by Stephan Dowless on 7/10/24.
//

import SwiftUI

public struct DotIndicator: View {
    private var status: ASDStatus? = nil
    private var color: Color? = nil
    private var borderColor: Color? = nil
    
    private var title: String? = nil
    private var labelColor: Color? = .primary
    
    init(_ title: String) {
        self.title = title
    }
    
    public var body: some View {
        Label {
            if let title {
                Text(title)
                    .font(.subheadline)
                    .foregroundStyle(labelColor ?? .primary)
            }
        } icon: {
            Circle()
                .fill(dotForegroundColor)
                .strokeBorder(dotBorderColor, lineWidth: 1)
                .frame(width: 12, height: 12)
        }
    }
}

public extension DotIndicator {
    func borderColor(_ color: Color?) -> Self {
        var copy = self
        copy.borderColor = color
        return copy
    }
    
    func color(_ color: Color?) -> Self {
        var copy = self
        copy.color = color
        return copy
    }
    
    func labelColor(_ color: Color?) -> Self {
        var copy = self
        copy.labelColor = color
        return copy
    }
    
    func status(_ status: ASDStatus?) -> Self {
        var copy = self
        copy.status = status
        return copy
    }
}

private extension DotIndicator {
    var dotBorderColor: Color {
        if let status {
            return color(for: status)
        }
        
        return borderColor ?? color(for: .default)
    }
    
    var dotForegroundColor: Color {
        if let status {
            return color(for: status)
        }
        
        return color ?? color(for: .default)
    }
    
    func color(for status: ASDStatus) -> Color {
        switch status {
        case .critical:
            return .red
        case .default:
            return .secondary
        case .favorable:
            return .green
        case .informational:
            return .blue
        case .warning:
            return .yellow
        }
    }
}

#Preview {
    DotIndicator("Approved")
        .status(.informational)
}
