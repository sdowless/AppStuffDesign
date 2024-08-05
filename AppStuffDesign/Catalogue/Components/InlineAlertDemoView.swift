//
//  InlineAlertDemoView.swift
//  AppStuffDesign
//
//  Created by Stephan Dowless on 8/5/24.
//

import SwiftUI

struct InlineAlertDemoView: View {
    @State private var title: String? = "Informational Title"
    @State private var message = "This is the message content to be dispalyed for your inline alert."
    @State private var isPresented = true
    @State private var dismissable = false
    @State private var alertStatus: DemoComponentStatus = .informational
    @State private var accessoryActionEnabled = false
    @State private var showTitle = true
    
    var body: some View {
        VStack {
            VStack {
                Group {
                    if accessoryActionEnabled {
                        inlineAlert
                            .accessoryAction("Accessory Action", action: {})
                    } else {
                        inlineAlert
                    }
                }
            }
            .frame(height: 140)
            
            List {
                Section("Title") {
                    Toggle("Show Title", isOn: $showTitle)
                        .tint(.blue)
                }
                
                Section("Message") {
                    TextField("Alert title", text: $message, axis: .vertical)
                }
                
                DemoOptionSection("Status", options: DemoComponentStatus.allCases, selectedItem: $alertStatus)
                
                Section("Action") {
                    Toggle("Enabled", isOn: $accessoryActionEnabled)
                        .tint(.blue)
                }
                
                Section("Presentation") {
                    Toggle("Dismissable", isOn: $dismissable)
                        .tint(.blue)
                }
            }
        }
        .navigationTitle("Inline Alert")
        .navigationBarTitleDisplayMode(.inline)
        .task(id: isPresented) {
            try? await Task.sleep(nanoseconds: 2_000_000_000)
            isPresented = true
        }
        .onChange(of: alertStatus) { oldValue, newValue in
            if showTitle {
                self.title = "\(alertStatus.rawValue) Title"
            }
        }
        .onChange(of: showTitle) { oldValue, newValue in
            if !newValue {
                title = nil
            } else {
                title = "\(alertStatus.rawValue) Title"
            }
        }
    }
}

private extension InlineAlertDemoView {
    var inlineAlert: InlineAlertView {
        InlineAlertView(
            title,
            message: message,
            systemImage: "paperplane.circle.fill",
            isPresented: $isPresented,
            isDismissable: dismissable
        )
        .variant(.status(alertStatus.status))
    }
}

#Preview {
    InlineAlertDemoView()
}
