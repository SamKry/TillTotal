//
//  ContentView.swift
//  TillTotal
//
//  Created by Samuel Kreyenbühl on 03.08.23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var container:NSPersistentContainer
    
    @ObservedObject var viewModel:ContentViewModel
    
    init(container: NSPersistentContainer) {
        self.container = container
        self.viewModel = ContentViewModel(container: container)
    }
    
    var body: some View {
        Button("init CHF"){
            viewModel.initTill()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(container: CoreDataManager.preview)
    }
}
