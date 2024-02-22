//
//  ContentView.swift
//  Сonverter
//
//  Created by Maxim P on 20/02/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var input = 10.0
    @State private var inputTemp = "Celsius"
    @State private var outputTemp = "Kelvin"
    @FocusState private var amountIsFocused: Bool
    
    let units = ["Fahrenheit", "Kelvin", "Celsius"]
    
    var result: String {
        let inputToCelsius: Double
        let celsiusToOutput: Double
        
        // Преобразование входного значения в градусы Цельсия
        switch inputTemp {
        case "Fahrenheit":
            inputToCelsius = (input - 32) * 5 / 9
        case "Kelvin":
            inputToCelsius = input - 273.15
        case "Celsius":
            inputToCelsius = input
        default:
            inputToCelsius = 1.0
        }
        
        // Преобразование градусов Цельсия в выбранную выходную единицу измерения
        switch outputTemp {
        case "Fahrenheit":
            celsiusToOutput = inputToCelsius * 9 / 5 + 32
        case "Kelvin":
            celsiusToOutput = inputToCelsius + 273.15
        case "Celsius":
            celsiusToOutput = inputToCelsius
        default:
            celsiusToOutput = 1.0
        }
        
        // Возвращаем результат в виде строки
        return String(celsiusToOutput)
    }

    
   
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Amount to convert") {
                    TextField("Amount", value: $input, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                }
                
//                Section("Fahrenheit temperature") {
//                    Text(celsiusToF, format: .number)
//                }
                Picker("Convert from", selection: $inputTemp) {
                    ForEach(units, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.navigationLink)
                
                Picker("Convert to", selection: $outputTemp) {
                    ForEach(units, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.navigationLink)
                
                Section("Result") {
                    Text(result)
                }
            }
            .navigationTitle("Temperature converter")
            .toolbar() {
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
