//
//  SlideToActDemoView.swift
//  AppStuffDesign
//
//  Created by Stephan Dowless on 8/5/24.
//

import SwiftUI

struct SlideToActDemoView: View {
    @State private var title = "Slide To Pay"
    @State private var isLoading = false
    
    var body: some View {
        VStack {
            VStack {
                SlideToActButton(title, isLoading: $isLoading) {
                    onSlideCompletion()
                }
                .padding()
            }
            .frame(height: 140)
            
            List {
                Section("Title") {
                    TextField("Title", text: $title)
                }
            }
        }
        .navigationTitle("Slide To Act")
        .navigationBarTitleDisplayMode(.inline)
    }
}

private extension SlideToActDemoView {
    func onSlideCompletion() {
        Task {
            try? await Task.sleep(nanoseconds: 2_000_000_000)
            isLoading.toggle()
        }
    }
}

#Preview {
    SlideToActDemoView()
}
