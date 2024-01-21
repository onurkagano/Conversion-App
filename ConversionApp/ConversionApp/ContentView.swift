//
//  ContentView.swift
//  Challange1
//
//  Created by onurkagano on 18.01.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedCategory: NavigationCategory = .temperature

    var body: some View {
        NavigationView {
            VStack {
                // Display the appropriate conversion view based on the selected category
                switch selectedCategory {
                case .temperature:
                    TemperatureConversionView()
                case .length:
                    LengthConversionView()
                case .time:
                    TimeConversionView()
                case .volume:
                    VolumeConversionView()
                }

                Spacer()
                // Navigation bar at the bottom
                ZStack{
                    HStack {
                        ForEach(NavigationCategory.allCases, id: \.self) { category in
                            Spacer()
                            Button(action: {
                                // Change the selected category when a button is tapped
                                selectedCategory = category
                            }) {
                                
                                // Use system images for symbols in the navigation bar
                                VStack{
                                    Image(systemName: category.symbolName)
                                        .imageScale(.large)
                                        .foregroundColor(category == selectedCategory ? selectedCategory.backgroundColor : .gray)
                                        .padding()
                                    Text(category.rawValue)
                                        .foregroundColor(category == selectedCategory ? selectedCategory.backgroundColor : .gray)
                                }
                            }
                            Spacer()
                        }
                        
                    }
                    .background(Color(hex: "28262b"))
                }

                
            }
            .background(selectedCategory.backgroundColor)
            .navigationTitle("Conversion App")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// Enum to represent the different conversion categories
enum NavigationCategory: String, CaseIterable {
    case temperature = "temperature"
    case length = "length"
    case time = "time"
    case volume = "volume"
    
    // Define system image names for symbols
    var symbolName: String {
        switch self {
        case .temperature:
            return "thermometer"
        case .length:
            return "ruler"
        case .time:
            return "clock"
        case .volume:
            return "drop.triangle.fill"
        }
    }
    
    // Define background colors for each category
    var backgroundColor: Color {
        switch self {
        case .temperature:
            return Color(hex: "d7dace") // Example color (yellow)
        case .length:
            return Color(hex: "ffe9b3") // Example color (blue)
        case .time:
            return Color(hex: "ffdc74") // Example color (red)
        case .volume:
            return Color(hex: "ffc176") // Example color (green)
        }
    }
}

// Additional views for each conversion category

struct TemperatureConversionView: View {
    @State private var inputValue = ""
    @State private var inputUnit: TemperatureUnit = .celsius
    @State private var outputUnit: TemperatureUnit = .kelvin
    @FocusState private var isFocused: Bool

    private var convertedValue: Double {
        let inputTemperature = Measurement(value: Double(inputValue) ?? 0, unit: inputUnit.unit)
        return inputTemperature.converted(to: outputUnit.unit).value
    }

    var body: some View {
        VStack {
            
            VStack{
                Text("Input Value")
                    .font(.headline)
                
                
                TextField("Enter value: \(inputUnit.symbol)", text: $inputValue)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .focused($isFocused)
                    .padding(.horizontal, 80.0)
            }
            .padding()
            VStack{
                Text("Converted Value:")
                    .font(.headline)
                
                Text("\(convertedValue.formatted()) \(outputUnit.symbol)")
                    .font(.title)
                    .foregroundColor(.black)
            }
            .padding()

            Text("Input Unit")
            Picker("Input Unit", selection: $inputUnit) {
                ForEach(TemperatureUnit.allCases, id: \.self) { unit in
                    Text(unit.symbol)
                }
            }
            .pickerStyle(.segmented)
            .padding()
            
            
            Text("Output Unit")
            Picker("Output Unit", selection: $outputUnit) {
                ForEach(TemperatureUnit.allCases, id: \.self) { unit in
                    Text(unit.symbol)
                }
            }
            .pickerStyle(.segmented)
            .padding()
            
        }
        .padding()
        .cornerRadius(10)
        .shadow(radius: 10)
        .toolbar {
            if isFocused {
                Button("Done") {
                    isFocused = false
                }
            }
        }
    }
}

// Enum to represent temperature units
enum TemperatureUnit: String, CaseIterable {
    case celsius
    case fahrenheit
    case kelvin

    var unit: UnitTemperature {
        switch self {
        case .celsius:
            return .celsius
        case .fahrenheit:
            return .fahrenheit
        case .kelvin:
            return .kelvin
        }
    }

    var symbol: String {
        switch self {
        case .celsius:
            return "°C"
        case .fahrenheit:
            return "°F"
        case .kelvin:
            return "K"
        }
    }
}



struct LengthConversionView: View {
    @State private var inputValue = ""
    @State private var inputUnit: LengthUnit = .meters
    @State private var outputUnit: LengthUnit = .miles
    @FocusState private var isFocused: Bool

    private var convertedValue: Double {
        let inputLength = Measurement(value: Double(inputValue) ?? 0, unit: inputUnit.unit)
        return inputLength.converted(to: outputUnit.unit).value
    }
    // Implement the length conversion view here
    var body: some View {
        VStack {
            
            VStack{
                Text("Input Value")
                    .font(.headline)
                
                
                TextField("Enter value: \(inputUnit.symbol)", text: $inputValue)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .focused($isFocused)
                    .padding(.horizontal, 80.0)
            }
            .padding()
            VStack{
                Text("Converted Value:")
                    .font(.headline)
                
                Text("\(convertedValue.formatted()) \(outputUnit.symbol)")
                    .font(.title)
                    .foregroundColor(.black)
            }
            .padding()

            Text("Input Unit")
            Picker("Input Unit", selection: $inputUnit) {
                ForEach(LengthUnit.allCases, id: \.self) { unit in
                    Text(unit.symbol).tag(unit)
                }
            }
            .pickerStyle(.segmented)
            .padding()
            
            
            Text("Output Unit")
            Picker("Output Unit", selection: $outputUnit) {
                ForEach(LengthUnit.allCases, id: \.self) { unit in
                    Text(unit.symbol).tag(unit)
                }
            }
            .pickerStyle(.segmented)
            .padding()
        }
        .padding()
        .cornerRadius(10)
        .shadow(radius: 10)
        .toolbar {
            if isFocused {
                Button("Done") {
                    isFocused = false
                }
            }
        }
    }
}

enum LengthUnit: String, CaseIterable {
    case meters
    case kilometers
    case feet
    case yards
    case miles

    var unit: UnitLength {
        switch self {
        case .meters:
            return .meters
        case .kilometers:
            return .kilometers
        case .feet:
            return .feet
        case .yards:
            return .yards
        case .miles:
            return .miles
        }
    }

    var symbol: String {
        switch self {
        case .meters:
            return "m"
        case .kilometers:
            return "km"
        case .feet:
            return "ft"
        case .yards:
            return "yd"
        case .miles:
            return "mi"
        }
    }
}

import SwiftUI

struct TimeConversionView: View {
    @State private var inputValue = ""
    @State private var inputUnit: TimeUnit = .seconds
    @State private var outputUnit: TimeUnit = .minutes
    @FocusState private var isFocused: Bool

    private var convertedValue: Double {
        let inputTime = Measurement(value: Double(inputValue) ?? 0, unit: inputUnit.unit)
        return inputTime.converted(to: outputUnit.unit).value
    }

    var body: some View {
        VStack {
            
            VStack{
                Text("Input Value")
                    .font(.headline)
                
                
                TextField("Enter value: \(inputUnit.symbol)", text: $inputValue)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .focused($isFocused)
                    .padding(.horizontal, 80.0)
            }
            .padding()
            
            VStack{
                Text("Converted Value:")
                    .font(.headline)
                
                Text("\(convertedValue.formatted()) \(outputUnit.symbol)")
                    .font(.title)
                    .foregroundColor(.black)
            }
            .padding()

            Text("Input Unit")
            Picker("Input Unit", selection: $inputUnit) {
                ForEach(TimeUnit.allCases, id: \.self) { unit in
                    Text(unit.symbol).tag(unit)
                }
            }
            .pickerStyle(.segmented)
            .padding()
            
            
            Text("Output Unit")
            Picker("Output Unit", selection: $outputUnit) {
                ForEach(TimeUnit.allCases, id: \.self) { unit in
                    Text(unit.symbol).tag(unit)
                }
            }
            .pickerStyle(.segmented)
            .padding()
            
        }
        .padding()
        .cornerRadius(10)
        .shadow(radius: 10)
        .toolbar {
            if isFocused {
                Button("Done") {
                    isFocused = false
                }
            }
        }
    }
}

// Enum to represent time units
enum TimeUnit: String, CaseIterable {
    case seconds
    case minutes
    case hours
    
    var unit: UnitDuration {
        switch self {
        case .seconds:
            return .seconds
        case .minutes:
            return .minutes
        case .hours:
            return .hours
        }
    }
    
    var symbol: String {
        switch self {
        case .seconds:
            return "sec"
        case .minutes:
            return "min"
        case .hours:
            return "hr"
        }
    }
}


struct VolumeConversionView: View {
    @State private var inputValue = ""
    @State private var inputUnit: VolumeUnit = .milliliters
    @State private var outputUnit: VolumeUnit = .liters
    @FocusState private var isFocused: Bool
    
    private var convertedValue: Double {
        let inputTime = Measurement(value: Double(inputValue) ?? 0, unit: inputUnit.unit)
        return inputTime.converted(to: outputUnit.unit).value
    }
    
    var body: some View {
        VStack {
            
            VStack{
                Text("Input Value")
                    .font(.headline)
                
                
                TextField("Enter value: \(inputUnit.symbol)", text: $inputValue)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .focused($isFocused)
                    .padding(.horizontal, 80.0)
            }
            .padding()
            
            VStack{
                Text("Converted Value:")
                    .font(.headline)
                
                Text("\(convertedValue.formatted()) \(outputUnit.symbol)")
                    .font(.title)
                    .foregroundColor(.black)
            }
            .padding()

            Text("Input Unit")
            Picker("Input Unit", selection: $inputUnit) {
                ForEach(VolumeUnit.allCases, id: \.self) { unit in
                    Text(unit.symbol).tag(unit)
                }
            }
            .pickerStyle(.segmented)
            .padding()
            
            
            Text("Output Unit")
            Picker("Output Unit", selection: $outputUnit) {
                ForEach(VolumeUnit.allCases, id: \.self) { unit in
                    Text(unit.symbol).tag(unit)
                }
            }
            .pickerStyle(.segmented)
            .padding()
            
        }
        .padding()
        .cornerRadius(10)
        .shadow(radius: 10)
        .toolbar {
            if isFocused {
                Button("Done") {
                    isFocused = false
                }
            }
        }
    }
}

enum VolumeUnit: String, CaseIterable {
    case milliliters
    case liters
    case cups
    case pints
    case gallons
    
    var unit: UnitVolume {
        switch self {
        case .milliliters:
            return .milliliters
        case .liters:
            return .liters
        case .cups:
            return .cups
        case .pints:
            return .pints
        case .gallons:
            return .gallons
        }
    }
    
    var symbol: String {
        switch self {
        case .milliliters:
            return "mL"
        case .liters:
            return "L"
        case .cups:
            return "cups"
        case .pints:
            return "pints"
        case .gallons:
            return "gallons"
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

