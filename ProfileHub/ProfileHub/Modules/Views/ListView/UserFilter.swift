//
//  UserFilter.swift
//  ProfileHub
//
//  Created by Santhosh G Patkar on 04/02/26.
//

import SwiftUI

struct CityFilterDropdownView: View {
    let cities: [String]
    @Binding var selectedCity: String?
    
    var allOptions: [String?] {
        [nil] + cities.sorted()
    }
    
    var body: some View {
        Picker(selection: $selectedCity) {
            Group {
                Text(Constants.allCities)
                    .tag(nil as String?)
                
                ForEach(cities.sorted(), id: \.self) { city in
                    Text(city)
                        .tag(city as String?)
                }
            }
        } label: {
            HStack(spacing: Constants.contentSpacing) {
                Image.decreaseCircle
                    .font(.system(size: Constants.iconFontSize))
                Text(selectedCity ?? Constants.filter)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .lineLimit(Constants.textLineLimit)
                Image.down
                    .font(.caption)
                    .fontWeight(.semibold)
            }
            .foregroundColor(.blue)
            .padding(Constants.padding)
            .background(backgroundColor)
            .cornerRadius(Constants.cornerRadius)
            .overlay(borderOverlay)
            .shadow(
                color: .black.opacity(Constants.shadowOpacity),
                radius: Constants.shadowRadius,
                x: Constants.shadowX,
                y: Constants.shadowY
            )
        }
        .pickerStyle(.menu)
    }
    
    private var backgroundColor: Color {
        selectedCity != nil
            ? Color.blue.opacity(Constants.selectedBackgroundOpacity)
            : Color(.systemBackground)
    }
    
    private var borderOverlay: some View {
        RoundedRectangle(cornerRadius: Constants.cornerRadius)
            .stroke(borderColor, lineWidth: Constants.borderLineWidth)
    }
    
    private var borderColor: Color {
        Color.blue.opacity(
            selectedCity != nil
                ? Constants.selectedBorderOpacity
                : Constants.unselectedBorderOpacity
        )
    }
}

// MARK: Preview
#Preview {
    VStack(spacing: 20) {
        CityFilterDropdownView(
            cities: ["India", "USA", "France"],
            selectedCity: .constant(nil)
        )
        
        CityFilterDropdownView(
            cities: ["India", "USA", "France"],
            selectedCity: .constant("India")
        )
    }
    .padding()
}

// MARK: Constants
extension CityFilterDropdownView {
    enum Constants {
        // Spacing & Padding
        static let contentSpacing: CGFloat = 8
        static let cornerRadius: CGFloat = 12
        static let padding: CGFloat = 14
        
        // Sizes
        static let iconFontSize: CGFloat = 16
        static let borderLineWidth: CGFloat = 1
        
        // Opacity
        static let selectedBackgroundOpacity: CGFloat = 0.1
        static let selectedBorderOpacity: CGFloat = 0.3
        static let unselectedBorderOpacity: CGFloat = 0.2
        static let shadowOpacity: CGFloat = 0.05
        
        // Shadow
        static let shadowRadius: CGFloat = 2
        static let shadowX: CGFloat = 0
        static let shadowY: CGFloat = 1
        
        // Strings
        static let allCities: String = "All Cities"
        static let filter: String = "Filter"
        
        // Line Limits
        static let textLineLimit: Int = 1
    }
}
