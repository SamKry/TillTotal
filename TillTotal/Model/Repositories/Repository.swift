//
//  Repository.swift
//  TillTotal
//
//  Created by Samuel Kreyenbühl on 28.07.23.
//

import CoreData

protocol Repository {
    
    /// The entity managed by the repository.
    associatedtype Entity
    
    /// Gets an array of entities.
    func getAll() async throws -> [Entity]
    
    /// Gets an entity by id
    /// - Parameter id: The id of the entity
    func getByID(id: UUID) async throws -> Entity?
    
    /// Creates an entity.
    func create() async throws -> Entity
    
    /// Deletes an entity
    /// - Parameter id: The id of the entity to be deleted
    func delete(id: UUID) async throws -> ()
    
    /// Deletes an entity.
    /// - Parameter entity: The entity to be deleted.
    func delete(entity: Entity) async throws -> ()
}
