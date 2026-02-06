//
//  UserListView.swift
//  ProfileHub
//
//  Created by Santhosh G Patkar on 04/02/26.
//

import SwiftUI

struct UserListView: View {
    @StateObject private var viewModel: UserListViewModel
    
    init(viewModel: UserListViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    // MARK: Main Body
    var body: some View {
        NavigationStack {
            VStack(spacing: Constants.containerSpacing) {
                filterHeaderView
                contentView
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle(Constants.navigationTitle)
            .navigationBarTitleDisplayMode(.inline)
            .refreshable {
                await viewModel.fetchUsers()
            }
        }
        .task {
            await viewModel.fetchUsers()
        }
    }

    private var filterHeaderView: some View {
        VStack(spacing: Constants.headerSpacing) {
            HStack(spacing: Constants.filterSpacing) {
                SearchTextField(text: $viewModel.searchText)
                CityFilterDropdownView(
                    cities: viewModel.cities,
                    selectedCity: $viewModel.selectedCity
                )
            }
            .padding(.horizontal, Constants.filterHorizontalPadding)
            .padding(.top, Constants.filterTopPadding)
            
            if !viewModel.isLoading && !viewModel.filteredUsers.isEmpty {
                resultsCounterView
            }
        }
        .background(Color(.systemGroupedBackground))
    }
    
    private var resultsCounterView: some View {
        HStack {
            Text("\(viewModel.filteredUsers.count)\(Constants.usersCountSuffix)")
                .font(.caption)
                .foregroundColor(.secondary)
            Spacer()
            if hasActiveFilters {
                clearFiltersButton
            }
        }
        .padding(.horizontal, Constants.resultsHorizontalPadding)
        .padding(.bottom, Constants.resultsBottomPadding)
    }
    
    private var clearFiltersButton: some View {
        Button {
            clearFilters()
        } label: {
            HStack(spacing: Constants.clearButtonSpacing) {
                Image.closeFill
                Text(Constants.clearFiltersText)
            }
            .font(.caption)
            .foregroundColor(.blue)
        }
    }

    private var contentView: some View {
        Group {
            if viewModel.isLoading {
                loadingView
            } else if viewModel.filteredUsers.isEmpty {
                emptyStateView
            } else {
                userListView
            }
        }
    }
    
    private var loadingView: some View {
        VStack {
            Spacer()
            VStack(spacing: Constants.loadingSpacing) {
                ProgressView()
                    .scaleEffect(Constants.progressViewScale)
                Text(Constants.loadingMessage)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
    }
    
    private var emptyStateView: some View {
        VStack {
            Spacer()
            VStack(spacing: Constants.emptyStateSpacing) {
                Text(Constants.emptyStateTitle)
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Text(Constants.emptyStateSubtitle)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                
                if shouldShowRetryButton {
                    retryButton
                }
            }
            .padding(Constants.emptyStatePadding)
            Spacer()
        }
    }
    
    private var retryButton: some View {
        Button {
            Task {
                await viewModel.fetchUsers()
            }
        } label: {
            Label(Constants.retryButtonText, systemImage: Constants.retryIconName)
                .padding(.horizontal, Constants.retryButtonHorizontalPadding)
                .padding(.vertical, Constants.retryButtonVerticalPadding)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(Constants.retryButtonCornerRadius)
        }
        .padding(.top, Constants.retryButtonTopPadding)
    }
    
    private var userListView: some View {
        ScrollView {
            LazyVStack(spacing: Constants.listSpacing) {
                ForEach(viewModel.filteredUsers) { user in
                    NavigationLink {
                        UserDetailView(user: user)
                    } label: {
                        UserRowView(user: user)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding(.horizontal, Constants.listHorizontalPadding)
            .padding(.vertical, Constants.listVerticalPadding)
        }
        .background(Color(.systemGroupedBackground))
    }
    
    private var hasActiveFilters: Bool {
        !viewModel.searchText.isEmpty || viewModel.selectedCity != nil
    }
    
    private var shouldShowRetryButton: Bool {
        viewModel.searchText.isEmpty && viewModel.selectedCity == nil
    }
    
    private func clearFilters() {
        viewModel.searchText = ""
        viewModel.selectedCity = nil
    }
}

// MARK: Preview
#Preview {
    UserListView(viewModel: UserListViewModel(apiService: APIService()))
}

// MARK: Constants
extension UserListView {
    enum Constants {
        // Spacing
        static let containerSpacing: CGFloat = 0
        static let headerSpacing: CGFloat = 12
        static let filterSpacing: CGFloat = 12
        static let loadingSpacing: CGFloat = 16
        static let emptyStateSpacing: CGFloat = 16
        static let listSpacing: CGFloat = 12
        static let clearButtonSpacing: CGFloat = 4
        
        // Padding
        static let filterHorizontalPadding: CGFloat = 16
        static let filterTopPadding: CGFloat = 8
        static let resultsHorizontalPadding: CGFloat = 20
        static let resultsBottomPadding: CGFloat = 4
        static let emptyStatePadding: CGFloat = 16
        static let retryButtonTopPadding: CGFloat = 8
        static let retryButtonHorizontalPadding: CGFloat = 20
        static let retryButtonVerticalPadding: CGFloat = 10
        static let listHorizontalPadding: CGFloat = 16
        static let listVerticalPadding: CGFloat = 12
        
        // Sizes
        static let progressViewScale: CGFloat = 1.2
        static let retryButtonCornerRadius: CGFloat = 10
        
        // Strings
        static let navigationTitle: String = "Users Details"
        static let loadingMessage: String = "Loading users..."
        static let emptyStateTitle: String = "No users found"
        static let emptyStateSubtitle: String = "Try adjusting your search or filter"
        static let clearFiltersText: String = "Clear filters"
        static let retryButtonText: String = "Retry"
        static let retryIconName: String = "arrow.clockwise"
        static let usersCountSuffix: String = " users"
    }
}
