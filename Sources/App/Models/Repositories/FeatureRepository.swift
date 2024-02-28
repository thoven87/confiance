//
//  FeatureRepository.swift
//
//
//  Created by Stevenson Michel on 2/21/24.
//

import Foundation

/// Interface for storing and editing Features
protocol FeatureRepository {
    /// Create a feature
    func create(state: FeatureState, description: String, version: UInt32, tags: [String], environementSettings: [String: ExperimentRule]) async throws -> Feature
    /// Find a feature
    func find(id: UUID) async throws -> Feature?
    /// List all features
    func list() async throws -> [Feature]
    /// Delete a feature
    func delete(id: UUID) async throws -> Bool
    /// Update a feature
    func update(id: UUID, description: String?) async throws -> Feature?
}
