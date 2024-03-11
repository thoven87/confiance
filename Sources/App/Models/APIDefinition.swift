//
//  APIDefinition.swift
//
//
//  Created by Stevenson Michel on 2/21/24.
//

import Foundation

struct CreateFeatureRequest: Decodable, Encodable {
    let description: String
    let state: String // TODO: map string to FeatureState enum
    let tags: [String]
}
