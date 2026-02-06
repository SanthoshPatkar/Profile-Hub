//
//  MockService.swift
//  ProfileHubTests
//
//  Created by Santhosh G Patkar on 04/02/26.
//

@testable import ProfileHub
import Foundation

final class MockAPIService: APIServiceProtocol {

    var usersToReturn: [User] = []
    var shouldThrowError = false
    private(set) var fetchCallCount = 0

    func fetchUsers() async throws -> [User] {
        fetchCallCount += 1

        if shouldThrowError {
            throw URLError(.badServerResponse)
        }
        return usersToReturn
    }
}
