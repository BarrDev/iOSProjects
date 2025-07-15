//
//  RecipeDetailView.swift
//  Cookcademy
//
//  Created by Joe L Barr on 1/16/24.
//

import SwiftUI

struct RecipeDetailView: View {
    @Binding var recipe: Recipe
    @State private var isPresenting = false
    @EnvironmentObject private var recipeData: RecipeData
    
    @AppStorage("listBackgroundColor") private var listBackgroundColor = AppColor.background
    @AppStorage("listTextColor") private var listTextColor = AppColor.foreground
    @AppStorage("hideOptionalSteps") private var hideOptionalSteps: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Text("Author: \(recipe.mainInformation.author)")
                    .font(.subheadline)
                    .padding()
                Spacer()
            }
            HStack {
                Text(recipe.mainInformation.description)
                    .font(.body)
                    .padding()
                Spacer()
            }
            List {
                Section(header: Text("Ingredients")) {
                    ForEach(recipe.ingredients.indices, id: \.self) { index in
                        let ingredient = recipe.ingredients[index]
                        Text(ingredient.description)
                            .foregroundStyle(listTextColor)
                    }
                }.listRowBackground(listBackgroundColor)
                Section(header: Text("Directions")) {
                    ForEach(recipe.directions.indices, id: \.self) { index in
                        let direction = recipe.directions[index]
                        if direction.isOptional && hideOptionalSteps {
                            EmptyView()
                        } else {
                            HStack {
                                let index = recipe.index(of: direction, excludingOptionalDirections: hideOptionalSteps) ?? 0
                                Text("\(index + 1). ").bold()
                                Text("\(direction.isOptional ? "(Optional) " : "")" + "\(direction.description)")
                            }
                            .foregroundStyle(listTextColor)
                        }
                    }
                    .listRowBackground(listBackgroundColor)
                }
            }
            .navigationTitle(recipe.mainInformation.name)
            .toolbar {
                ToolbarItem {
                    HStack {
                        Button("Edit") {
                            isPresenting = true
                        }
                        Button(action: {
                            recipe.isFavorite.toggle()
                        }) {
                            Image(systemName: recipe.isFavorite ? "heart.fill" : "heart")
                        }
                    }
                }
            }
            .sheet(isPresented: $isPresenting) {
                NavigationStack {
                    ModifyRecipeView(recipe: $recipe)
                        .toolbar {
                            ToolbarItem(placement: .confirmationAction) {
                                Button("Save") {
                                    isPresenting = false
                                }
                            }
                        }
                        .navigationTitle("Edit Recipe")
                }
                .onDisappear {
                    recipeData.saveRecipes()
                }
            }
        }
    }
}

#Preview {
    @State var recipe = Recipe.testRecipes[0]
   return NavigationStack {
        RecipeDetailView(recipe: $recipe)
    }
}
