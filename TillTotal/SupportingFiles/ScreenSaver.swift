//
//  ScreenSaver.swift
//  TillTotal
//
//  Created by Samuel Kreyenbühl on 31.12.2023.


import SwiftUI

class ScreenSaver: ObservableObject {
    @AppStorage("autoLock") var autoLock: Bool = false
    
    static let shared = ScreenSaver()
    
    init() {
        if(isAutoLockEnabled()){
            enableAutoLock()
        }
        else{
            disableAutoLock()
        }
        print("init Screen Saver")
        print(UIApplication.shared.isIdleTimerDisabled)
    }
    
    func enableAutoLock() {
        autoLock = true
        UIApplication.shared.isIdleTimerDisabled = false
        print("enable Auto Lock")
    }
    
    func disableAutoLock() {
        autoLock = false
        UIApplication.shared.isIdleTimerDisabled = true
        print("disable auto Lock")
    }
    
    func toggleAutoLock() {
        autoLock.toggle()
        UIApplication.shared.isIdleTimerDisabled = !autoLock
    }
    
    func isAutoLockEnabled() -> Bool {
        return autoLock
    }
}
