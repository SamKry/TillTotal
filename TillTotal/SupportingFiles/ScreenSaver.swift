//
//  ScreenSaver.swift
//  TillTotal
//
//  Created by Samuel Kreyenbühl on 31.12.2023.
//

import SwiftUI

class ScreenSaver{
    static func enableAutoLock(){
        UIApplication.shared.isIdleTimerDisabled = false
    }
    
    static func disableAutoLock(){
        UIApplication.shared.isIdleTimerDisabled = true
    }
    
    static func isAutoLockDisabled() -> Bool {
        return UIApplication.shared.isIdleTimerDisabled
    }
}
