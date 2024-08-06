//
//  TextInputDemoView.swift
//  AppStuffDesign
//
//  Created by Stephan Dowless on 8/5/24.
//

import SwiftUI

struct TextInputDemoView: View {
    @State private var axis: TextInputAxis = .horizontal
    @State private var clipShape: TextInputClipShape = .roundedRect
    @State private var error: Error?
    @State private var isLoading = false
    @State private var showError = false
    @State private var style: TextInputStyle = .filled
    @State private var text = "This is the input text for this demo view."

    var body: some View {
        VStack {
            VStack {
                ASDTextField("Placeholder..", text: $text, axis: axis.value)
                    .clipShape(clipShape.value)
                    .textFieldStyle(style.value)
                    .error(error: $error)
                    .accessoryAction("Send", isLoading: $isLoading) {
                        isLoading.toggle()
                    }
                    .loadable($isLoading)
            }
            .frame(height: 140)
            
            List {
                Section("Input") {
                    TextField("Text input..", text: $text, axis: .vertical)
                }
                
                Section("Loader") {
                    Toggle("Show Loader", isOn: $isLoading)
                        .tint(.blue)
                }
                
                Section("Error Handling") {
                    Toggle("Show Error", isOn: $showError)
                        .tint(.blue)
                }
                
                DemoOptionSection("Axis", options: TextInputAxis.allCases, selectedItem: $axis)
                
                DemoOptionSection("Clip Shape", options: TextInputClipShape.allCases, selectedItem: $clipShape)
                
                DemoOptionSection("Style", options: TextInputStyle.allCases, selectedItem: $style)
            }
            .font(.subheadline)
        }
        .navigationTitle("Text Input")
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: showError) { oldValue, newValue in
            if !oldValue {
                isLoading = !newValue
            }
            
            error = newValue ? TextInputError.loginFailed : nil
        }
    }
}

private extension TextInputDemoView {
    enum TextInputError: Error, LocalizedError {
        case loginFailed
        
        var errorDescription: String? {
            return "Login failed. Please try again."
        }
    }
    
    enum TextInputAxis: String, SectionViewModel {
        case horizontal = "Horizontal"
        case vertical = "Vertical"
        
        var value: Axis {
            switch self {
            case .horizontal:
                return .horizontal
            case .vertical:
                return .vertical
            }
        }
    }
    
    enum TextInputClipShape: String, SectionViewModel {
        case roundedRect = "Rounded Corners"
        case capsule = "Capsule"
        
        var value: ASDTextFieldClipShape {
            switch self {
            case .roundedRect:
                return .roundedRect
            case .capsule:
                return .capsule
            }
        }
    }
    
    enum TextInputStyle: String, SectionViewModel {
        case filled = "Filled"
        case bordered = "Bordered"
        
        var value: ASDTextFieldStyle {
            switch self {
            case .filled:
                return .backgroundFill
            case .bordered:
                return .bordered
            }
        }
    }
}
#Preview {
    TextInputDemoView()
}
