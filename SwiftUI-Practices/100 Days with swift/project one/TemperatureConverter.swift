//
//  ChallengeOne.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 14/06/2023.
// Converters Temperature

import SwiftUI
/*Length conversion, Time conversion, Volume conversion */

struct TemperatureConverter: View {
    
    @State private var checkValue: Measurement<UnitTemperature>?
    @State private var selectedUnit: UnitTemperature = .celsius
    
    //formatter
    private var temperatureFormatter : Formatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        
        return formatter
    }
    
    //computed property
    var convertedTemperature : String {
        guard let temperature = checkValue else { return "" }
        
        let convertedValue = temperature.converted(to: selectedUnit)
        let formatter         = MeasurementFormatter()
        formatter.unitStyle   = .medium
        formatter.unitOptions = .providedUnit
        
        return formatter.string(from: convertedValue)
    }
    
    var body: some View {
        Form{
            Section {
                
                TextField("Your temperature", value: $checkValue, formatter: temperatureFormatter)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                
                Picker("Temperature units", selection: $selectedUnit) {
                    Text("°C").tag(UnitTemperature.celsius)
                    Text("°F").tag(UnitTemperature.fahrenheit)
                    Text("K").tag(UnitTemperature.kelvin)
                }
                .pickerStyle(.segmented)
                .padding()
                
                Text("Converted Temperature: \(convertedTemperature)")
                    .padding()
            }
        }
        .onAppear{
            checkValue = Measurement(value: 25.0, unit: UnitTemperature.celsius)
        }
    }
}

struct ChallengeOne_Previews: PreviewProvider {
    static var previews: some View {
        TemperatureConverter()
    }
}
