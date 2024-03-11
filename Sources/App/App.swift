// The Swift Programming Language
// https://docs.swift.org/swift-book
// 
// Swift Argument Parser
// https://swiftpackageindex.com/apple/swift-argument-parser/documentation

import ArgumentParser
import Dispatch
import Hummingbird

@main
struct ConfianceArguments: AsyncParsableCommand, AppArguments {
    
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

