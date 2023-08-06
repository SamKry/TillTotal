//
//  TillEntityReopsitory.swift
//  TillTotal
//
//  Created by Samuel Kreyenbühl on 25.07.23.
//

import CoreData

class TillEntityReopsitory: Repository {
    
    let container: NSPersistentContainer
    typealias Entity = TillEntity
    
    init(container: NSPersistentContainer) {
        self.container = container
    }
    
    func getAll() throws -> [TillEntity] {
        let request = TillEntity.fetchRequest()
        return try container.viewContext.fetch(request)
    }
    
    func getByID(id: UUID) async throws -> TillEntity? {
        let request = TillEntity.fetchRequest()
        request.fetchLimit = 1
        request.predicate = NSPredicate(
            format: "id = %@", id.uuidString)
        let context =  container.viewContext
        let tillCoreDataEntity = try context.fetch(request)[0]
        return tillCoreDataEntity
    }
    
    func create() async throws -> TillEntity {
        let newEntity = TillEntity(context: container.viewContext)
        TillEntityReopsitory.saveContext()
        return newEntity
    }
    
    func delete(id: UUID) async throws -> (){
        let tillCoreDataEntity = try await getByID(id: id)!
        let context = container.viewContext;
        context.delete(tillCoreDataEntity)
        do{
            try context.save()
        }catch{
            context.rollback()
            fatalError("Error: \(error.localizedDescription)")
        }
    }
    
    func delete(entity: TillEntity) async throws {
        let context = container.viewContext;
        context.delete(entity)
        do{
            try context.save()
        }catch{
            context.rollback()
            fatalError("Error: \(error.localizedDescription)")
        }
    }
    
    static func saveContext(){
        CoreDataManager.instance.saveData()
    }
}
