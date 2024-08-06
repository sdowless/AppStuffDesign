//
//  SnackbarDemoView.swift
//  AppStuffDesign
//
//  Created by Stephan Dowless on 8/5/24.
//

import SwiftUI

struct SnackbarDemoView: View {
    @State private var showSnackbar = false
    @State private var message = "No Internet Connection."
    @State private var accessoryActionTitle = "Dismiss"
    @State private var entry: SnackbarEntry = .bottom
    @State private var duration: SnackbarDuration = .d1
    
    var body: some View {
        VStack {
            VStack {
                ASDButton("Tap To Preview") {
                    showSnackbar.toggle()
                }
            }
            .frame(height: 140)
            
            List {
                Section("Message") {
                    TextField("Message", text: $message)
                }
                
                Section("Accessory Action") {
                    TextField("Action Title", text: $accessoryActionTitle)
                }
                
                Section("Duration") {
                    Picker("Duration", selection: $duration) {
                        ForEach(SnackbarDuration.allCases, id: \.self) { duration in
                            Text("\(Int(duration.rawValue)) seconds")
                        }
                    }
                }
                
                DemoOptionSection("Entry Point", options: SnackbarEntry.allCases, selectedItem: $entry)
            }
        }
        .snackbar(
            message: message,
            systemImage: "wifi.slash",
            duration: duration,
            entryPosition: entry.value,
            show: $showSnackbar,
            accessoryAction: .init(title: accessoryActionTitle, handler: {
                showSnackbar.toggle()
            })
        )
    }
}

private extension SnackbarDemoView {
    enum SnackbarEntry: String, SectionViewModel {
        case top = "Top"
        case bottom = "Bottom"
        
        var value: SnackbarEntryPosition {
            switch self {
            case .top:
                return .top
            case .bottom:
                return .bottom
            }
        }
    }
}

#Preview {
    SnackbarDemoView()
}
