//
//  ContentView.swift
//  WeSplit
//
//  Created by Yazan Ghunaim on 6/16/23.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount: Double? = nil
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var isFocused: Bool
    
    let tipPercentages = [0,10,15,20,25]
    
    var totalPerPerson: Double {
        let peopleNo = Double(numberOfPeople + 2)
        let tipVal = Double (tipPercentage)
        
        return (((tipVal/100) * (checkAmount ?? 0.0)) + (checkAmount ?? 0.0)) / peopleNo
    }
    
    var currencyType: FloatingPointFormatStyle<Double>.Currency {
        return .currency(code: Locale.current.currency?.identifier ?? "USD")
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: currencyType)
                        .keyboardType(.decimalPad)
                        .focused($isFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<11) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                } header: {
                    Text("Tip")
                }
                
                Section {
                    Text(totalPerPerson * Double(numberOfPeople + 2), format: currencyType)
                        .foregroundColor(tipPercentage == 0 ? .red : .primary)
                } header: {
                    Text("Total")
                }
                
                Section {
                    Text(totalPerPerson, format: currencyType)
                        .foregroundColor(tipPercentage == 0 ? .red : .primary)
                } header: {
                    Text("Amount per person")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar { // modifier which lets us specify toolbars for the view
                ToolbarItemGroup(placement: .keyboard) { // placing toolbars on keyboard
                    Spacer() // flexible space push views depending on where we use them
                    
                    Button("Done") {
                        isFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
