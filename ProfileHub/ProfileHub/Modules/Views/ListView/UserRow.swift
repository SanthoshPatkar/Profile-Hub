//
//  UserRowView.swift
//  ProfileHub
//
//  Created by Santhosh G Patkar on 04/02/26.
//

import SwiftUI

struct UserRowView: View {
    let user: User
    
    // MARK: Main Body
    var body: some View {
        HStack(spacing: Constants.contentSpacing) {
            avatarView
            userInfoView
            Image.rightArrow
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.leading, Constants.chevronLeadingPadding)
        }
        .padding(Constants.containerPadding)
        .background(Color.background)
        .cornerRadius(Constants.cornerRadius)
        .shadow(
            color: Constants.shadowColor.opacity(Constants.shadowOpacity),
            radius: Constants.shadowRadius,
            x: Constants.shadowX,
            y: Constants.shadowY
        )
    }
    
    private var avatarView: some View {
        ZStack {
            Circle()
                .fill(LinearGradient(
                    colors: Constants.avatarGradientColors,
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ))
                .frame(width: Constants.avatarSize, height: Constants.avatarSize)
            
            Text(user.name.prefix(1))
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.white)
        }
    }
    
    private var userInfoView: some View {
        VStack(alignment: .leading, spacing: Constants.itemSpacing) {
            userHeaderView
            contactInfoView
            companyView
        }
    }
    
    private var userHeaderView: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: Constants.nameSpacing) {
                Text(user.name)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .lineLimit(Constants.textLineLimit)
                
                Text("@\(user.username)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(Constants.textLineLimit)
            }
            
            Spacer()
            
            Text(user.address.city)
                .font(.caption)
                .fontWeight(.medium)
                .padding(.horizontal, Constants.badgeHorizontalPadding)
                .padding(.vertical, Constants.badgeVerticalPadding)
                .background(Color.blue.opacity(Constants.badgeBackgroundOpacity))
                .foregroundColor(.blue)
                .cornerRadius(Constants.badgeCornerRadius)
        }
    }
    
    private var contactInfoView: some View {
        VStack(alignment: .leading, spacing: Constants.itemSpacing) {
            iconTextRow(icon: Image.email, text: user.email, color: .secondary)
            iconTextRow(icon: Image.phone, text: user.phone, color: .secondary)
        }
    }
    
    private var companyView: some View {
        iconTextRow(icon: Image.building, text: user.company.name, color: .orange)
            .padding(.top, Constants.badgeTopPadding)
    }
    
    private func iconTextRow(icon: Image, text: String, color: Color) -> some View {
        HStack(spacing: Constants.itemSpacing) {
            icon
                .font(.caption)
                .foregroundColor(color)
                .frame(width: Constants.iconFrameWidth)
            Text(text)
                .font(.caption)
                .foregroundColor(color)
                .fontWeight(color == .orange ? .medium : .regular)
                .lineLimit(Constants.textLineLimit)
        }
    }
}

// MARK: Preview
#Preview {
    UserRowView(user: User(
        id: 1,
        name: "John Doe",
        username: "johndoe",
        email: "john@example.com",
        phone: "123-456-7890",
        address: Address(
            street: "123 Main St",
            suite: "Apt 1",
            city: "New York",
            zipcode: "10001",
            geo: Geo(lat: "0", lng: "0")
        ),
        company: Company(
            name: "Tech Corp",
            catchPhrase: "Innovation",
        )
    ))
    .padding()
}

// MARK: Constants
extension UserRowView {
    enum Constants {
        // Spacing
        static let contentSpacing: CGFloat = 12
        static let itemSpacing: CGFloat = 6
        static let nameSpacing: CGFloat = 4
        static let badgeTopPadding: CGFloat = 2
        static let chevronLeadingPadding: CGFloat = 4
        
        // Padding
        static let containerPadding: CGFloat = 14
        static let badgeHorizontalPadding: CGFloat = 10
        static let badgeVerticalPadding: CGFloat = 4
        
        // Sizes
        static let avatarSize: CGFloat = 56
        static let iconFrameWidth: CGFloat = 14
        static let cornerRadius: CGFloat = 14
        
        // Shadow
        static let shadowOpacity: CGFloat = 0.06
        static let shadowRadius: CGFloat = 4
        static let shadowX: CGFloat = 0
        static let shadowY: CGFloat = 2
        
        // Colors
        static let avatarGradientColors: [Color] = [.blue.opacity(0.8), .purple.opacity(0.8)]
        static let badgeBackgroundOpacity: CGFloat = 0.1
        static let shadowColor: Color = .black
        
        // Badge
        static let badgeCornerRadius: CGFloat = 8
        
        // Line Limits
        static let textLineLimit: Int = 1
    }
}
