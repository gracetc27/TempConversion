//
//  ContentView.swift
//  TempConversion
//
//  Created by Grace couch on 16/07/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var inputNumber = 0.0
    @State private var inputUnit: UnitTemperature = .celsius
    @State private var outputUnit: UnitTemperature = .fahrenheit
    @FocusState var isFocused: Bool

    let units: [UnitTemperature] = [.celsius, .fahrenheit, .kelvin]
    let formatter: MeasurementFormatter = {
        let f = MeasurementFormatter()
        f.unitStyle = .short
        f.unitOptions = .providedUnit
        return f
    }()

        var body: some View {
        NavigationStack {
            Form {
                Section("Choose your input unit") {
                    Picker("Input Unit", selection: $inputUnit) {
                        ForEach(units, id: \.self) {
                            Text(formatter.string(from: $0))
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section("Enter your temperature") {
                    TextField("Enter your temperature", value: $inputNumber, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($isFocused)
                }
                Section("choose your output unit") {
                    Picker("Output Unit", selection: $outputUnit) {
                        ForEach(units, id: \.self) {
                            Text(formatter.string(from: $0))
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section("converted temperature") {
                    let inputTemp = Measurement(value: inputNumber, unit: inputUnit)
                    let convertedTemp = inputTemp.converted(to: outputUnit)
                    Text(formatter.string(from: convertedTemp))
                }
            }
            .navigationTitle("Convert Temperatures")
            .toolbar {
                if isFocused {
                    Button("Done") {
                        isFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
