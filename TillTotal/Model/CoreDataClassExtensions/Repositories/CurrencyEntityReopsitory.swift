//
//  CurrencyEntityReopsitory.swift
//  CurrencyTotal
//
//  Created by Samuel Kreyenbühl on 28.07.23.
//

import CoreData


class CurrencyEntityReopsitory:Repository {
    
    let container: NSPersistentContainer
    typealias Entity = CurrencyEntity
    
    init(container: NSPersistentContainer) {
        self.container = container
    }
    
    func getAll() throws -> [CurrencyEntity] {
        let request = CurrencyEntity.fetchRequest()
        return try container.viewContext.fetch(request)
    }
    
    func getByID(id: UUID) throws -> CurrencyEntity? {
        let request = CurrencyEntity.fetchRequest()
        request.fetchLimit = 1
        request.predicate = NSPredicate(
            format: "id = %@", id.uuidString)
        let context =  container.viewContext
        let CurrencyCoreDataEntity = try context.fetch(request)[0]
        return CurrencyCoreDataEntity
    }
    
    func create() throws -> CurrencyEntity {
        let newEntity = CurrencyEntity(context: container.viewContext)
        saveContext()
        return newEntity
    }
    
    func delete(id: UUID) throws {
        let currencyCoreDataEntity = try getByID(id: id)!
        let context = container.viewContext;
        context.delete(currencyCoreDataEntity)
        do{
            try context.save()
        }catch{
            context.rollback()
            fatalError("Error: \(error.localizedDescription)")
        }
    }
    
    func delete(entity: CurrencyEntity) throws {
        let context = container.viewContext;
        context.delete(entity)
        do{
            try context.save()
        }catch{
            context.rollback()
            fatalError("Error: \(error.localizedDescription)")
        }
    }

    private func saveContext(){
        CoreDataManager.instance.saveData()
    }
}
