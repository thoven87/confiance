//
//  FeatureMemoryRepository.swift
//
//
//  Created by Stevenson Michel on 2/21/24.
//

import Foundation

actor FeatureMemoryRepository: FeatureRepository {
    
    var features: [UUID: Feature]
    
    init() {
        self.features = [:]
    }
    
    func create(state: FeatureState = FeatureState.draft, description: String, version: UInt32, tags: [String], environementSettings: [String: ExperimentRule]) async throws -> Feature {
        let id = UUID()
        let feature = Feature(
            id: id,
            state: state,
            description: description,
            version: version,
            tags: tags,
            enviromentSettings: environementSettings
        )
        self.features[id] = feature
        return feature
    }
    
    func find(id: UUID) async throws -> Feature? {
        return self.features[id]
    }
    
    func list() async throws -> [Feature] {
        return self.features.values.map { $0 }
    }
    
    func delete(id: UUID) async throws -> Bool {
        if self.features[id] != nil {
            self.features[id] = nil
            return true
        }
        return false
    }
    
    func update(id: UUID, description: String?) async throws -> Feature? {
        if var feature = self.features[id] {
            if let description {
                feature.description = description
            }
            self.features[id] = feature
            return feature
        }
        return nil
    }
    
    
}
