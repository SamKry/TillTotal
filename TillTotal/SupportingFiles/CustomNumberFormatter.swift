//
//  CustomNumberFormatter.swift
//  CalcBlue
//
//  Created by Samuel Kreyenbühl on 18.05.23.
//

import SwiftUI

class CustomNumberFormatter: NumberFormatter {
    
    public static func getIntFormatter() -> NumberFormatter{
        return intFormatter
    }
    
    public static func getDecimalFormatter() -> NumberFormatter{
        return decimalFormatter
    }
    
    static let decimalFormatter: NumberFormatter = {
        let formatter = CustomNumberFormatter()
        formatter.numberStyle = .decimal
        formatter.usesGroupingSeparator = false // Remove commas
        formatter.minimumFractionDigits = 2 // TODO: not sure if this is needed
        return formatter
    }()

    static let intFormatter: NumberFormatter = {
        let formatter = CustomNumberFormatter()
        formatter.numberStyle = .decimal
        formatter.usesGroupingSeparator = false // Remove commas
        formatter.maximumFractionDigits = 0
        return formatter
    }()
    
    override func string(for obj: Any?) -> String? {
        guard let value = obj as? NSNumber else {
            return super.string(for: obj)
        }
        
        if value.doubleValue == 0 {
            return "" // Treat zero as an empty string
        }
        
        return super.string(for: obj)
    }
    
    override func getObjectValue(_ obj: AutoreleasingUnsafeMutablePointer<AnyObject?>?, for string: String, errorDescription error: AutoreleasingUnsafeMutablePointer<NSString?>?) -> Bool {
        do {
            super.getObjectValue(obj, for: string, errorDescription: error)
            if string.isEmpty {
                obj?.pointee = NSNumber(value: 0) // Set the value to 0 when the string is empty
            }
            return true
        }
    }
}

