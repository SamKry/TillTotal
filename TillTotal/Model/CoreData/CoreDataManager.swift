//
//  CoreDataManager.swift
//  TillTotal
//
//  Created by Samuel Kreyenbühl on 24.07.23.
//

import CoreData

class CoreDataManager{
    static let instance = CoreDataManager()
    let container: NSPersistentContainer
    let context: NSManagedObjectContext    
    
    init(){
        container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores { (description, error) in
            if let error = error{
                print("ERRIOR LOADING CORE DATA FROM CoreDataManager. \(error)")
            }
        }
        context = container.viewContext
    }
        
    private var debounceTimer: Timer?
    
    func saveData(forceSave:Bool = false) {
        if(forceSave) {
            saveDataNow()
            return
        }
        debounceTimer?.invalidate() // Invalidate the existing timer
        
        // Create a new timer that delays the saveData() call
        debounceTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { [weak self] _ in
            self?.saveDataNow()
        }
    }
    
    public func saveDataNow() {
        if (container.viewContext.hasChanges) {
            do{
                try container.viewContext.save()
                print("Saved sucessfully")
            } catch let error{
                print("ERROR SAVING. \(error)")
            }
        }
        else{
            print("Nothing to save")
        }
    }
}
