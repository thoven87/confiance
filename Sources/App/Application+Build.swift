//
//  File.swift
//  
//
//  Created by Stevenson Michel on 2/22/24.
//

import Foundation
import Hummingbird
import Logging

protocol AppArguments {
    var hostname: String { get }
    var port: Int { get }
    var inMemoryTesting: Bool { get }
}


/// Build an HBApplication
func buildApplication(_ args: AppArguments) async throws -> some HBApplicationProtocol {
    var logger = Logger(label: "confiance")
    logger.logLevel = .debug
    
    /// create router
    let router = HBRouter()
    
    /// Repository
    let repository: FeatureMemoryRepository = FeatureMemoryRepository()
    
    /// add middleware
    router.middlewares.add(HBLogRequestsMiddleware(.info))
    
    /// Add health router
    router.get("/health") { _, _ in
        return HTTPResponse.Status.ok
    }
    
    let apiV1Routes = router.group("api/v1")
    FeaturesController(repository: repository).addRoutes(to: apiV1Routes.group("features"))
    
    /// create application
    let app = HBApplication(
        router: router,
        configuration: .init(
            address: .hostname(args.hostname, port: args.port),
            serverName: "confiance",
            reuseAddress: true
        ),
        logger: logger
    )
    
    /// return app
    return app
}
