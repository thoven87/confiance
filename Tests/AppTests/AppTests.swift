//
//  ConfianceTests.swift.swift
//
//
//  Created by Stevenson Michel on 2/21/24.
//

@testable import App
import Foundation
import Hummingbird
import HummingbirdXCT
import XCTest

final class AppTests: XCTestCase {
    struct TestArguments: AppArguments {
        let hostname: String = "127.0.0.1"
        let port: Int = 7090
        let inMemoryTesting: Bool = true
    }
    
    internal func create(data: CreateFeatureRequest, client: some HBXCTClientProtocol) async throws -> [Feature] {
        let buffer = try JSONEncoder().encodeAsByteBuffer(data, allocator: .init())
        
        return try await client.XCTExecute(uri: "/api/v1/features", method: .post, body: buffer) { response in
            XCTAssertEqual(response.status, .ok)
            let feature = try JSONDecoder().decode([Feature].self, from: response.body)
            return feature
        }
    }
    
    /// MARK: Tests
    func testCreateFeature() async throws {
        let app = try await buildApplication(TestArguments())
        
        try await app.test(.router) { client in
            let feature = CreateFeatureRequest(
                description: "Some features", state: "draft", tags: ["Onboarding", "New User Flow"]
            )
            let response = try await self.create(data: feature, client: client)
            XCTAssertEqual(response.description, feature.description)
        }
    }
}
