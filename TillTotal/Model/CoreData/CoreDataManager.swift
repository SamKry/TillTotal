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
    
    static var preview: NSPersistentContainer {
        let container = NSPersistentContainer(name: "Model - PREVIEW")
        let description = NSPersistentStoreDescription()
        description.url = URL(fileURLWithPath: "/dev/null")
        container.persistentStoreDescriptions = [description]
        
        container.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Error creating preview store: \(error)")
            }
        }
        return container
    }

    
    init(){
        container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores { (description, error) in
            if let error = error{
                print("ERRIOR LOADING CORE DATA FROM CoreDataManager. \(error)")
            }
        }
        context = container.viewContext
    }
    
    func saveData(){
        saveData(forceSave: false)
    }
    
    func saveData(forceSave:Bool){
        if (forceSave || container.viewContext.hasChanges) {
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
