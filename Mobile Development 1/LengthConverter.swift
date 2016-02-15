import Foundation

enum LengthUnit {
    case Metre, Foot, Yard, Mile
    
    static let values = [ Metre, Foot, Yard, Mile ]
    
    private static let names = [
        Metre: "Metre",
        Foot: "Foot",
        Yard: "Yard",
        Mile: "Mile"
    ]
    
    var name: String {
        get {
            return LengthUnit.names[self]!
        }
    }
}

class LengthConverter {
    
    private let conversionFactors: [LengthUnit: Double]
    
    var fromUnit: LengthUnit
    var toUnit: LengthUnit
    
    init() {
        fromUnit = LengthUnit.Metre
        toUnit = LengthUnit.Metre
        
        conversionFactors = [
            LengthUnit.Foot: 0.3048,
            LengthUnit.Metre: 1,
            LengthUnit.Mile: 1609.344,
            LengthUnit.Yard: 0.9144
        ]
    }
    
    func convert(value: Double) -> Double {
        return value * conversionFactors[fromUnit]! / conversionFactors[toUnit]!
    }
    
    func reverseConvert(value: Double) -> Double {
        return value / conversionFactors[fromUnit]! * conversionFactors[toUnit]!
    }
    
}