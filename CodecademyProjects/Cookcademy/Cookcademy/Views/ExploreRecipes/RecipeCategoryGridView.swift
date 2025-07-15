//
//  RecipeCategoryGridView.swift
//  Cookcademy
//
//  Created by Joe L Barr on 1/16/24.
//

import SwiftUI

struct RecipeCategoryGridView: View {
    @EnvironmentObject private var recipeData: RecipeData
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(), GridItem()]) {
                    ForEach(MainInformation.Category.allCases, id: \.self) { category in
                        NavigationLink(destination: RecipesListView(viewStyle: .singleCategory(category) ).environmentObject(recipeData), label: {CategoryView(category: category)})
                    }
                    .navigationTitle("Categories")
                }
            }
        }
    }
}

struct CategoryView: View {
    let category: MainInformation.Category
    
    var body: some View {
        ZStack {
            Image(category.rawValue)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .opacity(0.35)
            Text(category.rawValue)
                .font(.title)
        }
    }
}

#Preview {
    RecipeCategoryGridView()
}
