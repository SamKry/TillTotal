//
//  CoinEntityReopsitory.swift
//  coinTotal
//
//  Created by Samuel Kreyenbühl on 25.07.23.
//

import CoreData

class CoinEntityReopsitory: Repository {
    
    let container: NSPersistentContainer
    typealias Entity = CoinEntity
    
    init(container: NSPersistentContainer) {
        self.container = container
    }
    
    func getAll() async throws -> [CoinEntity] {
        let request = CoinEntity.fetchRequest()
        return try container.viewContext.fetch(request)
    }
    
    func getByID(id: UUID) async throws -> CoinEntity? {
        let request = CoinEntity.fetchRequest()
        request.fetchLimit = 1
        request.predicate = NSPredicate(
            format: "id = %@", id.uuidString)
        let context =  container.viewContext
        let coinCoreDataEntity = try context.fetch(request)[0]
        return coinCoreDataEntity
    }
    
    func create() async throws -> CoinEntity {
        let newEntity = CoinEntity(context: container.viewContext)
        saveContext()
        return newEntity
    }
    
    func delete(id: UUID) async throws -> (){
        let coinCoreDataEntity = try await getByID(id: id)!
        let context = container.viewContext;
        context.delete(coinCoreDataEntity)
        do{
            try context.save()
        }catch{
            context.rollback()
            fatalError("Error: \(error.localizedDescription)")
        }
    }
    
    func delete(entity: CoinEntity) async throws {
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
