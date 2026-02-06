//
//  UserDetailView.swift
//  ProfileHub
//
//  Created by Santhosh G Patkar on 04/02/26.
//

import SwiftUI

struct UserDetailView: View {

    let user: User

    // MARK: Main Body
    var body: some View {
        ScrollView {
            VStack(spacing: Constants.containerSpacing) {
                headerView
                contactSection
                addressSection
                companySection
            }
            .padding(.vertical, Constants.containerVerticalPadding)
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle(user.name)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var headerView: some View {
        VStack(spacing: Constants.headerSpacing) {
            ZStack {
                Circle()
                    .fill(LinearGradient(
                        colors: Constants.avatarGradientColors,
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ))
                    .frame(width: Constants.avatarSize, height: Constants.avatarSize)
                
                Text(user.name.prefix(1))
                    .font(.system(size: Constants.avatarFontSize, weight: .bold))
                    .foregroundColor(.white)
            }
            Text(user.name)
                .font(.title2)
                .fontWeight(.bold)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, Constants.headerVerticalPadding)
    }
    
    private var contactSection: some View {
        VStack(alignment: .leading, spacing: Constants.sectionSpacing) {
            sectionHeader(
                title: Constants.contactSectionTitle,
                iconName: Constants.contactIconName
            )
            
            VStack(spacing: Constants.contactRowSpacing) {
                infoRow(
                    icon: Constants.emailIconName,
                    text: user.email,
                    color: .red
                )
                infoRow(
                    icon: Constants.phoneIconName,
                    text: user.phone,
                    color: .green
                )
            }
        }
        .padding(Constants.sectionPadding)
        .background(Color.background)
        .cornerRadius(Constants.sectionCornerRadius)
        .shadow(
            color: .black.opacity(Constants.shadowOpacity),
            radius: Constants.shadowRadius,
            x: Constants.shadowX,
            y: Constants.shadowY
        )
        .padding(.horizontal, Constants.sectionHorizontalPadding)
    }
    
    private var addressSection: some View {
        VStack(alignment: .leading, spacing: Constants.sectionSpacing) {
            sectionHeader(
                title: Constants.addressSectionTitle,
                iconName: Constants.addressIconName
            )
            
            VStack(alignment: .leading, spacing: Constants.addressItemSpacing) {
                addressRow
            }
        }
        .padding(Constants.sectionPadding)
        .background(Color.background)
        .cornerRadius(Constants.sectionCornerRadius)
        .shadow(
            color: .black.opacity(Constants.shadowOpacity),
            radius: Constants.shadowRadius,
            x: Constants.shadowX,
            y: Constants.shadowY
        )
        .padding(.horizontal, Constants.sectionHorizontalPadding)
    }
    
    private var addressRow: some View {
        HStack(alignment: .top, spacing: Constants.addressItemSpacing) {
            Image.houseFill
                .foregroundColor(.orange)
                .frame(width: Constants.addressIconWidth)
            
            VStack(alignment: .leading, spacing: Constants.addressDetailSpacing) {
                Text("\(user.address.street), \(user.address.suite)")
                    .font(.body)
                Text(user.address.city)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text(user.address.zipcode)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .padding(Constants.addressRowPadding)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.secondarySystemGroupedBackground))
        .cornerRadius(Constants.itemCornerRadius)
    }
    
    private var companySection: some View {
        VStack(alignment: .leading, spacing: Constants.sectionSpacing) {
            sectionHeader(
                title: Constants.companySectionTitle,
                iconName: Constants.companyIconName
            )
            
            companyRow
        }
        .padding(Constants.sectionPadding)
        .background(Color.background)
        .cornerRadius(Constants.sectionCornerRadius)
        .shadow(
            color: .black.opacity(Constants.shadowOpacity),
            radius: Constants.shadowRadius,
            x: Constants.shadowX,
            y: Constants.shadowY
        )
        .padding(.horizontal, Constants.sectionHorizontalPadding)
    }
    
    private var companyRow: some View {
        HStack(spacing: Constants.companySpacing) {
            companyAvatar
            
            VStack(alignment: .leading, spacing: Constants.companyDetailSpacing) {
                Text(user.company.name)
                    .font(.headline)
                
                Text(user.company.catchPhrase)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding(Constants.companyRowPadding)
        .background(Color(.secondarySystemGroupedBackground))
        .cornerRadius(Constants.itemCornerRadius)
    }
    
    private var companyAvatar: some View {
        ZStack {
            Circle()
                .fill(LinearGradient(
                    colors: Constants.companyGradientColors,
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ))
                .frame(width: Constants.companyAvatarSize, height: Constants.companyAvatarSize)
            
            Text(user.company.name.prefix(1))
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.white)
        }
    }
    
    private func sectionHeader(title: String, iconName: String) -> some View {
        Label(title, systemImage: iconName)
            .font(.headline)
            .foregroundColor(.blue)
    }
    
    private func infoRow(icon: String, text: String, color: Color) -> some View {
        HStack(spacing: Constants.infoRowSpacing) {
            ZStack {
                Circle()
                    .fill(color.opacity(Constants.iconBackgroundOpacity))
                    .frame(width: Constants.iconCircleSize, height: Constants.iconCircleSize)
                
                Image(systemName: icon)
                    .foregroundColor(color)
                    .font(.system(size: Constants.iconFontSize))
            }
            
            Text(text)
                .font(.body)
            
            Spacer()
        }
        .padding(.vertical, Constants.infoRowVerticalPadding)
        .padding(.horizontal, Constants.infoRowHorizontalPadding)
        .background(Color(.secondarySystemGroupedBackground))
        .cornerRadius(Constants.itemCornerRadius)
    }
}

// MARK: Preview
#Preview {
    NavigationStack {
        UserDetailView(user: User(
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
    }
}

// MARK: Constants
extension UserDetailView {
    enum Constants {
        // Spacing
        static let containerSpacing: CGFloat = 24
        static let headerSpacing: CGFloat = 12
        static let sectionSpacing: CGFloat = 16
        static let addressItemSpacing: CGFloat = 8
        static let addressDetailSpacing: CGFloat = 4
        static let companySpacing: CGFloat = 12
        static let companyDetailSpacing: CGFloat = 4
        static let infoRowSpacing: CGFloat = 12
        static let contactRowSpacing: CGFloat = 12
        
        // Padding
        static let headerVerticalPadding: CGFloat = 20
        static let sectionPadding: CGFloat = 16
        static let sectionHorizontalPadding: CGFloat = 16
        static let addressRowPadding: CGFloat = 16
        static let companyRowPadding: CGFloat = 16
        static let containerVerticalPadding: CGFloat = 16
        static let infoRowVerticalPadding: CGFloat = 8
        static let infoRowHorizontalPadding: CGFloat = 12
        
        // Sizes
        static let avatarSize: CGFloat = 100
        static let avatarFontSize: CGFloat = 42
        static let companyAvatarSize: CGFloat = 50
        static let iconCircleSize: CGFloat = 36
        static let iconFontSize: CGFloat = 14
        static let addressIconWidth: CGFloat = 20
        
        // Corner Radius
        static let sectionCornerRadius: CGFloat = 12
        static let itemCornerRadius: CGFloat = 8
        
        // Shadow
        static let shadowOpacity: CGFloat = 0.05
        static let shadowRadius: CGFloat = 5
        static let shadowX: CGFloat = 0
        static let shadowY: CGFloat = 2
        
        // Colors
        static let avatarGradientColors: [Color] = [.blue, .purple]
        static let companyGradientColors: [Color] = [.orange, .pink]
        static let iconBackgroundOpacity: CGFloat = 0.1
        
        // Strings
        static let contactSectionTitle: String = "Contact"
        static let contactIconName: String = "person.crop.circle.fill"
        static let addressSectionTitle: String = "Address"
        static let addressIconName: String = "location.fill"
        static let companySectionTitle: String = "Company"
        static let companyIconName: String = "building.2.fill"
        static let emailIconName: String = "envelope.fill"
        static let phoneIconName: String = "phone.fill"
    }
}
