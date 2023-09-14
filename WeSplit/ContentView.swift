//
//  ContentView.swift
//  WeSplit
//
//  Created by Godwin IE on 09/09/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused : Bool
    
    let userCurrency : FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currency?.identifier ?? "NGN")
    
    var totalAmount : Double {
        let tipValue = checkAmount / 100 * Double(tipPercentage)
        let amount = checkAmount + tipValue
        return amount
    }
    
//    let tipPercentages = [10,15,20,25,0]
    let tipPercentages = Array(0...100)

    
    var totalPerPerson : Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
        
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: userCurrency)
                    .keyboardType(.decimalPad)
                    .focused($amountIsFocused)
                    
                    Picker ("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text ("\($0) people")
                        }
                    }
                }
                
                Section{
                    Picker ("Tip percentage", selection: $tipPercentage) {
                        ForEach (tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.wheel)
                } header: {
                    Text("How much tip do you want to leave?")
                }
                
                Section (header: Text("Amount per person")) {
                    Text(totalPerPerson, format: userCurrency)
                }
                
                Section (header: Text("Total amount")) {
                    Text(totalAmount, format: userCurrency)
                }
            } //Form
            .navigationTitle("We Split")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
            // .padding()
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
