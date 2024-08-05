//
//  ButtonDemoView.swift
//  AppStuffDesign
//
//  Created by Stephan Dowless on 8/4/24.
//

import SwiftUI

struct ButtonDemoView: View {
    @State private var isLoading = false
    @State private var rankOption: ButtonRank = .primary
    @State private var standardSizeOption: StandardButtonSize = .large
    @State private var iconSizeOption: IconButtonSize = .default
    @State private var variantOption: ButtonVariant = .default
    @State private var buttonStyle: ButtonStyle = .standard
    
    var body: some View {
        VStack {
            Group {
                switch buttonStyle {
                case .icon:
                    ASDButton(systemImage: "paperplane", action: onTap)
                        .buttonStyle(
                            .icon(
                                rank: rankOption.rank,
                                size: iconSizeOption.size,
                                variant: variantOption.variant
                            ),
                            isLoading: $isLoading
                        )
                case .standard:
                    ASDButton("Click Me") {
                        onTap()
                    }
                    .buttonStyle(
                        .standard(
                            rank: rankOption.rank,
                            size: standardSizeOption.standardSize,
                            variant: variantOption.variant,
                            iconLayout: .leading
                        ),
                        isLoading: $isLoading
                    )
                }
            }
            .frame(height: 120)
            
            List {
                DemoOptionSection("Styles", options: ButtonStyle.allCases, selectedItem: $buttonStyle)
                
                DemoOptionSection("Rank", options: ButtonRank.allCases, selectedItem: $rankOption)
                
                Group {
                    switch buttonStyle {
                    case .icon:
                        DemoOptionSection("Sizing", options: IconButtonSize.allCases, selectedItem: $iconSizeOption)
                    case .standard:
                        DemoOptionSection("Sizing", options: StandardButtonSize.allCases, selectedItem: $standardSizeOption)
                    }
                }
                
                DemoOptionSection("Variant", options: ButtonVariant.allCases, selectedItem: $variantOption)
            }
        }
        .navigationTitle("Button")
        .navigationBarTitleDisplayMode(.inline)
    }
}

private extension ButtonDemoView {
    func onTap() {
        Task {
            isLoading = true
            try? await Task.sleep(nanoseconds: 2_000_000_000)
            isLoading = false
        }
    }
}

private extension ButtonDemoView {
    enum ButtonRank: String, SectionViewModel {
        case primary = "Primary"
        case secondary = "Secondary"
        case tertiary = "Tertiary"
        
        var rank: ASDButtonRank {
            switch self {
            case .primary:
                return .primary
            case .secondary:
                return .secondary
            case .tertiary:
                return .tertiary
            }
        }
    }
    
    enum StandardButtonSize: String, SectionViewModel {
        case compact = "Compact"
        case small = "Small"
        case medium = "Medium"
        case large = "Large"
        
        var standardSize: ASDStandardButtonSize {
            switch self {
            case .compact:
                return .compact
            case .small:
                return .small
            case .medium:
                return .medium
            case .large:
                return .large
            }
        }
    }
    
    enum IconButtonSize: String, SectionViewModel {
        case `default` = "Default"
        case large = "Large"
        
        var size: ASDIconButtonSize {
            switch self {
            case .default:
                return .default
            case .large:
                return .large
            }
        }
    }
    
    enum ButtonVariant: String, SectionViewModel {
        case critical = "Critical"
        case `default` = "Default"
        case neutral = "Neutral"
        case onImage = "On Image"
        
        var variant: ASDButtonVariant {
            switch self {
            case .critical:
                return .critical
            case .default:
                return .default
            case .neutral:
                return .neutral
            case .onImage:
                return .onImage
            }
        }
    }
    
    enum ButtonStyle: String, SectionViewModel {
        case icon = "Icon"
        case standard = "Standard"
    }
}

#Preview {
    ButtonDemoView()
}


