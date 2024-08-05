//
//  DotIndicatorDemoView.swift
//  AppStuffDesign
//
//  Created by Stephan Dowless on 8/5/24.
//

import SwiftUI

struct DotIndicatorDemoView: View {
    @State private var title = "Approved"
    @State private var dotStatus: DemoComponentStatus = .informational
    
    var body: some View {
        VStack {
            VStack {
                DotIndicator(title)
                    .status(dotStatus.status)
            }
            .frame(height: 100)
            
            List {
                Section("Title") {
                    TextField("Enter title", text: $title)
                }
                
                DemoOptionSection("Status", options: DemoComponentStatus.allCases, selectedItem: $dotStatus)
            }
        }
    }
}

#Preview {
    DotIndicatorDemoView()
}
