//
//  Feature.swift
//
//
//  Created by Stevenson Michel on 2/21/24.
//

import Foundation
import Hummingbird

enum FeatureState: Encodable, Decodable {
    case archived
    case active
    case draft
    case deleted
}

struct Schema: Encodable, Decodable {
    /// Schema
    var schema: String
    /// date
    var date: Date
    
    /// enabled
    var enabled: Bool
}

struct ScheduleRule: Encodable, Decodable {
    /// Timestamp
    var timestamp: Int
    /// Enabled
    var enabled: Bool
}

enum Targeting: Encodable, Decodable {
    case all
    case any
    case none
}

enum RuleType: Encodable, Decodable {
    case rollout
    case force
    case experiment
}

struct ExperimentRule: Encodable, Decodable {
    /// ID
    var id: UUID
    /// description
    var decription: String
    /// condition
    var condition: String?
    /// enabled
    var enabled: Bool
    /// schedule rules
    var scheduleRules: [ScheduleRule]?
    /// savedGroups
    var savedGroups: [UUID: Targeting]?
    
    var type: RuleType
}

struct Feature {
    /// ID
    var id: UUID
    
    /// state
    var state: FeatureState
    
    /// description
    var description: String
    
    /// version
    var version: UInt32
    
    /// tags
    var tags: [String]
    
    // linkedExperiments
    var linkedExperiments: [String]?
    
    /// schema
    var jsonSchema: Schema?
    
    var enviromentSettings: [String: ExperimentRule]
}

extension Feature: HBResponseEncodable, Decodable, Equatable {
    
    /// TODO finish writting compare function
    static func == (lhs: Feature, rhs: Feature) -> Bool {
        lhs.description == rhs.description
    }
}
