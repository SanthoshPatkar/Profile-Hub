//
//  SearchTextField.swift
//  ProfileHub
//
//  Created by Santhosh G Patkar on 04/02/26.
//

import SwiftUI

struct SearchTextField: View {
    @Binding var text: String
    @FocusState private var isFocused: Bool
    
    var body: some View {
        HStack(spacing: Constants.spacing) {
            Image.search
                .foregroundColor(isFocused ? .blue : .secondary)
                .font(.system(size: Constants.fontSize))
            
            TextField(Constants.placeholder, text: $text)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .focused($isFocused)
            
            if !text.isEmpty {
                Button {
                    text = Constants.emptyString
                } label: {
                    Image.clear
                        .foregroundColor(.secondary)
                        .font(.system(size: Constants.fontSize))
                }
                .transition(.scale.combined(with: .opacity))
            }
        }
        .padding(Constants.padding)
        .background(Color.background)
        .cornerRadius(Constants.cornerRadius)
        .overlay(focusBorder)
        .animation(.easeInOut(duration: Constants.animationDuration), value: isFocused)
        .animation(.easeInOut(duration: Constants.animationDuration), value: text)
    }
    
    private var focusBorder: some View {
        RoundedRectangle(cornerRadius: Constants.cornerRadius)
            .stroke(isFocused ? Color.blue : Color.clear, lineWidth: Constants.borderLineWidth)
    }
}

// MARK: Preview
#Preview {
    VStack(spacing: 20) {
        SearchTextField(text: .constant(""))
        SearchTextField(text: .constant("data"))
    }
    .padding()
}

// MARK: Constants
extension SearchTextField {
    enum Constants {
        // Spacing & Padding
        static let cornerRadius: CGFloat = 12
        static let padding: CGFloat = 12
        static let spacing: CGFloat = 10
        
        // Sizes
        static let fontSize: CGFloat = 16
        static let borderLineWidth: CGFloat = 1.5
        
        // Animation
        static let animationDuration: Double = 0.2
        
        // Strings
        static let placeholder: String = "Search by name or username"
        static let emptyString: String = ""
    }
}
