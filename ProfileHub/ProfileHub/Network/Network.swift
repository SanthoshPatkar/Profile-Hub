//
//  Network.swift
//  ProfileHub
//
//  Created by Santhosh G Patkar on 04/02/26.
//

import Foundation

protocol APIServiceProtocol {
    func fetchUsers() async throws -> [User]
}

final class APIService: APIServiceProtocol {
    
    private let url = URL(string: "https://jsonplaceholder.typicode.com/users")!
    
    func fetchUsers() async throws -> [User] {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              200..<300 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode([User].self, from: data)
    }
}
