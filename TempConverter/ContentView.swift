//
//  ContentView.swift
//  TempConverter
//
//  Created by Filippo on 13/12/23.
//

import SwiftUI

struct ContentView: View {
    @State private var userChoice1 : String = "Celsius"
    @State private var userChoice2 : String = "Fahrenheit"
    @State private var value : Float = 0.0
    @FocusState private var isValueFocused : Bool
    
    let temperaturesUnits = ["Celsius", "Fahrenheit", "Kelvin"]
    
    var body: some View {
        NavigationStack{
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
               
                
            }
            .navigationTitle("Temperature Converter")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if isValueFocused {
                    Button("Done") {
                        isValueFocused = false
                            }
                        }
                }
            
            var convertedTemperature : Float {
                var converted : Float
                
                switch userChoice1 {
                case "Celsius":
                    switch userChoice2 {
                    case "Fahrenheit":
                        converted = value + 32.0
                    case "Kelvin":
                        converted = value + 273.0
                    default:
                        converted = value
                    }
                case "Fahrenheit":
                    switch userChoice2 {
                    case "Celsius":
                        converted = value - 32.0
                    case "Kelvin":
                        converted = value + 241.0
                    default:
                        converted = value
                    }
                case "Kelvin":
                    switch userChoice2 {
                    case "Fahrenheit":
                        converted = value - 241.0
                    case "Celsius":
                        converted = value - 273.0
                    default:
                        converted = value
                    }
                default:
                    converted = value
                }
                return converted
            }
            
            HStack{
                VStack {
                    Text(userChoice1)
                   
                    var formattedValue : String {
                        var intValue : String = "0"
                        let decimalPart = value.truncatingRemainder(dividingBy: 1)
                        if decimalPart != 0 {
                            intValue = String(format: "%.2f", value)
                        } else {
                            intValue = String(format: "%.0f", value)
                        }
                            return intValue + "˚" + String(userChoice1.first!)
                        }
                    
                    Text("\(formattedValue)")
                        .font(.title)
                }
                Spacer()
                VStack{
                    Text(userChoice2)
                    var formattedTemp : String {
                        var intValue : String = "0"
                        let decimalPart = convertedTemperature.truncatingRemainder(dividingBy: 1)
                        if decimalPart != 0 {
                            intValue = String(format: "%.2f", convertedTemperature)
                        } else {
                            intValue = String(format: "%.0f", convertedTemperature)
                        }
                        return intValue + "˚" + String(userChoice2.first!)
                        }
                    Text("\(formattedTemp)")
                        .font(.title)
                    }
                    
                   
            }.padding()
                
            }
            
        }
        
    }


#Preview {
    ContentView()
}
