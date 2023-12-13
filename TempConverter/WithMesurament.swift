//
//  WithMesurament.swift
//  TempConverter
//
//  Created by Filippo on 13/12/23.
//

import SwiftUI

struct WithMesurament: View {
    @State private var userChoice1 : String = "Celsius"
    @State private var userChoice2 : String = "Fahrenheit"
    @State private var value : Double = 0.0
    @FocusState private var isValueFocused : Bool
    
    let temperaturesUnits = ["Celsius", "Fahrenheit", "Kelvin"]
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, content: {
                        Text("Insert a temperature")
                            .font(.body)
                        Spacer()
                        TextField("Value", value: $value, format: .number)
                            .keyboardType(.decimalPad)
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .fixedSize()
                            .focused($isValueFocused)
                    })
                    
                }
                Section {
                        VStack(alignment: .leading, content: {
                            Text("From")
                            Picker("From", selection: $userChoice1){
                                ForEach(temperaturesUnits, id: \.self){
                                    Text($0)
                                }
                            }.pickerStyle(.segmented)
                                .padding(3)
                        })
                }
                Section {
                        VStack(alignment: .leading, content: {
                            Text("To")
                            Picker("From", selection: $userChoice2){
                                ForEach(temperaturesUnits, id: \.self){
                                    Text($0)
                                }
                            }.pickerStyle(.segmented)
                                .padding(3)
                        })
                }
                Section {
                    var unitChoise1 : UnitTemperature {
                        var unit: UnitTemperature
                        switch userChoice1 {
                        case "Celsius":
                            unit = .celsius;
                        case "Fahrenheit":
                            unit = .fahrenheit
                        case "Kelvin":
                            unit = .kelvin
                        default:
                            unit = .celsius
                        }
                        return unit
                    }
                    var unitChoise2 : UnitTemperature {
                        var unit: UnitTemperature
                        switch userChoice2 {
                        case "Celsius":
                            unit = .celsius;
                        case "Fahrenheit":
                            unit = .fahrenheit
                        case "Kelvin":
                            unit = .kelvin
                        default:
                            unit = .celsius
                        }
                        return unit
                    }
                   
                    let original = Measurement(value: value, unit: unitChoise1)
                    
                    HStack{
                        VStack {
                            Text(userChoice1)
                                .font(.body)
                            Text("\(original.value.formatted()) ˚\(String(userChoice1.first!))")
                                .font(.title)
                        }
                        Spacer()
                        VStack {
                            Text(userChoice2)
                                .font(.body)
                            Text("\(original.converted(to: unitChoise2).value.formatted()) ˚\(String(userChoice2.first!))")
                                .font(.title)
                        }
                    }
                }
                
                
                
            }.navigationTitle("Temperature Converter")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    if isValueFocused {
                        Button("Done") {
                            isValueFocused = false
                                }
                            }
                    }
        }
    }
}

#Preview {
    WithMesurament()
}
