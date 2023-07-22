//
//  TillTotalApp.swift
//  TillTotal
//
//  Created by Samuel Kreyenbühl on 15.07.23.
//

import SwiftUI

@main
struct TillTotalApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }}
