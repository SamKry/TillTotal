//
//  HapticFeedback.swift
//  TillTotal
//
//  Created by Samuel Kreyenbühl on 11.08.23.
//

import SwiftUI


class HapticFeedback {
    public static func ok () {
        let impactOK = UIImpactFeedbackGenerator(style: .heavy)
        impactOK.impactOccurred()
    }
    
    public static func error () {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
    }
}
