//
//  ContentView.swift
//  AppStuffDesign
//
//  Created by Stephan Dowless on 8/2/24.
//

import SwiftUI

struct DropdownDemoView: View {
    @State private var selectedPaymentOption: PaymentOptions?
    @State private var selectedLoanType: LoanType?
    
    @State private var showSelectionSheet = false
    @State private var showError = false
    @State private var title = "Payment Options"
    
    var body: some View {
        VStack {
            VStack {
                Dropdown(title, selection: $selectedPaymentOption)
                    .alertable(showError, message: "An error ocurred")
                    .onTapGesture { showSelectionSheet.toggle() }
                    .padding()
            }
            .frame(height: 140)
            
            List {
                Section("Title") {
                    TextField("Enter title", text: $title)
                }
                
                Section("Error Handling") {
                    Toggle("Show Error", isOn: $showError)
                        .tint(.blue)
                }
            }
        }
        .navigationTitle("Dropdown")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showSelectionSheet) {
            SelectionSheet(
                "Payment Options",
                options: PaymentOptions.allCases,
                selection: $selectedPaymentOption
            )
            .padding(.vertical)
            .presentationDetents([.medium])
        }
    }
}

private extension DropdownDemoView {
    enum SheetConfig: Identifiable {
        case paymentOptions
        case loanType
        
        var id: Int { return self.hashValue }
    }
}

enum PaymentOptions: SelectionProtocol {
    case biWeekly
    case semiMonthly
    case monthly
    case annual
    
    var description: String {
        switch self {
        case .biWeekly:
            return "Bi-Weekly"
        case .semiMonthly:
            return "Semi-Monthly"
        case .monthly:
            return "Monthly"
        case .annual:
            return "Annual"
        }
    }
    
    var id: Int { return self.hashValue }
}

enum LoanType: SelectionProtocol {
    case auto
    case home
    case personal
    
    var description: String {
        switch self {
        case .auto:
            return "Auto"
        case .home:
            return "Home"
        case .personal:
            return "Personal"
        }
    }
    
    var id: Int { return self.hashValue }
}

#Preview {
    DropdownDemoView()
}
