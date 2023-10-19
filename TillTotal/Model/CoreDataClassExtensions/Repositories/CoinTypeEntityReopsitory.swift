//
//  CoinTypeEntityReopsitory.swift
//  coinTypeTotal
//
//  Created by Samuel Kreyenbühl on 25.07.23.
//

import CoreData

class CoinTypeEntityReopsitory:Repository {

    let container: NSPersistentContainer
    typealias Entity = CoinTypeEntity
    
    init(container: NSPersistentContainer) {
        self.container = container
    }
    
    func getAll() throws -> [CoinTypeEntity] {
        let request = CoinTypeEntity.fetchRequest()
        let vals = try container.viewContext.fetch(request)
        return vals
    }
    
    func getByID(id: UUID) throws -> CoinTypeEntity? {
        let request = CoinTypeEntity.fetchRequest()
        request.fetchLimit = 1
        request.predicate = NSPredicate(
            format: "id = %@", id.uuidString)
        let context =  container.viewContext
        let coinTypeCoreDataEntity = try context.fetch(request)[0]
        return coinTypeCoreDataEntity
    }
    
    func create() throws -> CoinTypeEntity {
        let newEntity = CoinTypeEntity(context: container.viewContext)
        saveContext()
        return newEntity
    }
    
    func delete(id: UUID) throws -> (){
        let coinTypeCoreDataEntity = try getByID(id: id)!
        let context = container.viewContext;
        context.delete(coinTypeCoreDataEntity)
        do{
            try context.save()
        }catch{
            context.rollback()
            fatalError("Error: \(error.localizedDescription)")
        }
    }
    
    func delete(entity: CoinTypeEntity) throws {
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
