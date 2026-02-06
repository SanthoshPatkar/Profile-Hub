//
//  ProfileHubTests.swift
//  ProfileHubTests
//
//  Created by Santhosh G Patkar on 04/02/26.
//

import XCTest
@testable import ProfileHub

@MainActor
final class ProfileHubTests: XCTestCase {
    private var mockService: MockAPIService!
    private var viewModel: UserListViewModel!
    
    override func setUp() {
        super.setUp()
        mockService = MockAPIService()
        viewModel = UserListViewModel(apiService: mockService)
    }
    
    override func tearDown() {
        mockService = nil
        viewModel = nil
        super.tearDown()
    }
    
    // MARK: - API Tests
    
    func test_fetchUsers_success_updatesUsers() async {
        mockService.usersToReturn = User.mockUsers
        
        await viewModel.fetchUsers()
        
        XCTAssertEqual(viewModel.users.count, 2)
        XCTAssertFalse(viewModel.isLoading)
    }
    
    func test_fetchUsers_failure_setsError() async {
        mockService.shouldThrowError = true
        
        await viewModel.fetchUsers()
        
        XCTAssertTrue(viewModel.users.isEmpty)
        XCTAssertFalse(viewModel.isLoading)
    }
    
    // MARK: - Filtering Tests
    
    func test_searchFiltersByName() {
        viewModel.setUsersForTesting(User.mockUsers)
        viewModel.searchText = "Leanne"
        
        XCTAssertEqual(viewModel.filteredUsers.count, 1)
        XCTAssertEqual(viewModel.filteredUsers.first?.name, "Leanne Graham")
    }
    
    func test_searchFiltersByUsername() {
        viewModel.setUsersForTesting(User.mockUsers)
        viewModel.searchText = "Antonette"
        
        XCTAssertEqual(viewModel.filteredUsers.count, 1)
    }
    
    func test_cityFilterWorks() {
        viewModel.setUsersForTesting(User.mockUsers)
        viewModel.selectedCity = "Chennai"
        
        XCTAssertEqual(viewModel.filteredUsers.count, 1)
        XCTAssertEqual(viewModel.filteredUsers.first?.address.city, "Chennai")
    }
    
    func test_combinedSearchAndCityFilter() {
        viewModel.setUsersForTesting(User.mockUsers)
        viewModel.searchText = "Leanne"
        viewModel.selectedCity = "Chennai"
        
        XCTAssertEqual(viewModel.filteredUsers.count, 1)
    }
    
    func test_combinedSearchAndCityFilter_Failure() {
        viewModel.setUsersForTesting(User.mockUsers)
        viewModel.searchText = "Lenne"
        viewModel.selectedCity = "Chenai"
        
        XCTAssertEqual(viewModel.filteredUsers.count, 0)
    }
    
    func test_noResults_whenFiltersDoNotMatch() {
        viewModel.setUsersForTesting(User.mockUsers)
        viewModel.searchText = "Random"
        
        XCTAssertTrue(viewModel.filteredUsers.isEmpty)
    }
}
