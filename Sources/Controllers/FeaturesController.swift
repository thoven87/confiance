//
//  FeaturesController.swift
//
//
//  Created by Stevenson Michel on 2/21/24.
//

import Foundation
import Hummingbird

struct FeaturesController<Context: HBRequestContext, Repository: FeatureRepository> {
    let repository: Repository
    
    func addRoutes(to group: HBRouterGroup<Context>) {
        group
            .get(use: all)
    }
    
    @Sendable func all(req: HBRequest, context: Context) async throws -> HBEditedResponse<Feature> {
        let content = try await req.decode(as: CreateFeatureRequest.self, context: context)
        
        let feature = try await self.repository.create(
            state: FeatureState.draft,
            description: content.description,
            version: 1,
            tags: content.tags,
            environementSettings: .init()
        )
        
        return HBEditedResponse(status: .created, response: feature)
        
    }
}
