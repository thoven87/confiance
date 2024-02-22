// The Swift Programming Language
// https://docs.swift.org/swift-book
// 
// Swift Argument Parser
// https://swiftpackageindex.com/apple/swift-argument-parser/documentation

import ArgumentParser
import Hummingbird
import Logging

protocol AppArguments {
    var hostname: String { get }
    var port: Int { get }
    var inMemoryTesting: Bool { get }
}

@main
struct confiance: AsyncParsableCommand, AppArguments {
    
    @Option(name: .shortAndLong)
    var hostname: String = "127.0.0.1"
    
    @Option(name: .shortAndLong)
    var port: Int = 7090
    
    @Flag
    var inMemoryTesting: Bool = false
    
    func run() async throws {
        let app = try await buildApplication(self)
        
        try await app.runService()
    }
}

/// Build an HBApplication
func buildApplication(_ args: AppArguments) async throws -> some HBApplicationProtocol {
    var logger = Logger(label: "Confiance")
    logger.logLevel = .debug
    
    /// create router
    let router = HBRouter()
    
    /// add middleware
    router.middlewares.add(HBLogRequestsMiddleware(.info))
    
    
    /// Add health router
    router.get("/health") { _, _ in
        "PONG\n"
    }
    
    /// create application
    let app = HBApplication(
        router: router,
        configuration: .init(
            address: .hostname(args.hostname, port: args.port),
            serverName: "[Confiance]",
            reuseAddress: true
        ),
        logger: logger
    )
    
    let repository: FeatureMemoryRepository = FeatureMemoryRepository()
    
    FeaturesController(repository: repository).addRoutes(to: router.group("features"))
    
    /// return app
    return app
}
