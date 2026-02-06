//
//  ProfileHubApp.swift
//  ProfileHub
//
//  Created by Santhosh G Patkar on 04/02/26.
//

import SwiftUI

@main
struct ProfileHubApp: App {
    var body: some Scene {
        WindowGroup {
            UserListView(viewModel: UserListViewModel(apiService: APIService()))
        }
    }
}
