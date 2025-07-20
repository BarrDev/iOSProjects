import SwiftUI

enum TipOption: Hashable {
    case predefined(Int)
    case custom

    var label: String {
        switch self {
        case .predefined(let value):
            return "\(value)%"
        case .custom:
            return "Other"
        }
    }

    var value: Int {
        switch self {
        case .predefined(let value):
            return value
        case .custom:
            return -1 // placeholder
        }
    }
}

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var selectedTipOption: TipOption = .predefined(20)
    @State private var customTip = 0
    @FocusState private var amountIsFocused: Bool

    let tipOptions: [TipOption] = [
        .predefined(0), .predefined(5), .predefined(10),
        .predefined(15), .predefined(20), .predefined(25),
        .custom
    ]

    var tipPercentage: Double {
        switch selectedTipOption {
        case .predefined(let value):
            return Double(value)
        case .custom:
            return Double(customTip)
        }
    }

    var grandTotal: Double {
        let tipValue = checkAmount * tipPercentage / 100
        return checkAmount + tipValue
    }

    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople)
        return grandTotal / peopleCount
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Amount per Person") {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }

                Section("Total Amount") {
                    Text(grandTotal, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }

                Section("Check Amount") {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                }

                Section("Number of People") {
                    Picker("Number of People", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }

                Section("Tip Percentage") {
                    Picker("Tip Percentage", selection: $selectedTipOption) {
                        ForEach(tipOptions, id: \.self) { option in
                            Text(option.label)
                        }
                    }
                    .pickerStyle(.segmented)

                    if selectedTipOption == .custom {
                        TextField("Enter custom tip %", value: $customTip, format: .number)
                            .keyboardType(.numberPad)
                            .transition(.opacity.combined(with: .move(edge: .top)))
                    }
                }
                .animation(.default, value: selectedTipOption)
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
