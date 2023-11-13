//
//  KeyboardHandler.swift
//  TillTotal
//
//  Created by Samuel Kreyenbühl on 11.08.23.
//

import SwiftUI

class KeyboardHandler {
    public static func hideKeyboard(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
