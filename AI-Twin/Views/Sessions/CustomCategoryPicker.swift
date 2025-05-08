//
//  CustomCategoryPicker.swift
//  AI-Twin
//
//  Created by Dominic Kchau on 05/05/2025.
//

import SwiftUI

struct CustomCategoryPicker: View {
    @Binding var selectedCategory: SessionCategory

    let categories = SessionCategory.allCases

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack(spacing: 20) {
                ForEach(categories) { category in
                    VStack(spacing: 8) {
                        Image(systemName: category.icon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                            .foregroundStyle(selectedCategory == category ? .white : .gray)
                            .padding(14)
                            .background(
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(selectedCategory == category ? Color.color1 : Color.gray.opacity(0.2))
                            )
                        
                        Text(category.title)
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(selectedCategory == category ? .black : .gray)
                    }
                    .onTapGesture {
                        selectedCategory = category
                    }
                }
            }
                    .padding(13)
        }
        .background(.gray.opacity(0.1))
        .cornerRadius(12)

    }
}

