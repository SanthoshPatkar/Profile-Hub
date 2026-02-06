//
//  UserListViewModel.swift
//  ProfileHub
//
//  Created by Santhosh G Patkar on 04/02/26.
//

import Foundation
import Combine

@MainActor
final class UserListViewModel: ObservableObject {
    
    @Published private(set) var users: [User] = []
    @Published var searchText: String = ""
    @Published var selectedCity: String? = nil
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let apiService: APIServiceProtocol
    
    init(apiService: APIServiceProtocol) {
        self.apiService = apiService
    }
    
    func fetchUsers() async {
        isLoading = true
        errorMessage = nil
        
        do {
            users = try await apiService.fetchUsers()
        } catch {
            errorMessage = "Failed to load users"
        }
        
        isLoading = false
    }
    
    var filteredUsers: [User] {
        users.filter { user in
            let matchesSearch =
            searchText.isEmpty ||
            user.name.lowercased().contains(searchText.lowercased()) ||
            user.username.lowercased().contains(searchText.lowercased())
            
            let matchesCity =
            selectedCity == nil || user.address.city == selectedCity
            
            return matchesSearch && matchesCity
        }
    }
    
    var cities: [String] {
        Set(users.map { $0.address.city }).sorted()
    }
    
    #if DEBUG
    func setUsersForTesting(_ users: [User]) {
        self.users = users
    }
    #endif
}
