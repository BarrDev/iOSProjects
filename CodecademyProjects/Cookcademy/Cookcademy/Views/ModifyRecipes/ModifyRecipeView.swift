//
//  ModifyRecipeView.swift
//  Cookcademy
//
//  Created by Joe L Barr on 1/17/24.
//

import SwiftUI

struct ModifyRecipeView: View {
    @Binding var recipe: Recipe
    @State private var selection = Selection.main
    @State private var isPresenting = false
    
    var body: some View {
        VStack {
            Spacer()
            Picker("Select recipe component", selection: $selection) {
                Text("Main Info").tag(Selection.main)
                Text("Ingredients").tag(Selection.ingredients)
                Text("Directions").tag(Selection.directions)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            switch selection {
            case .main:
                ModifyMainInformationView(mainInformation: $recipe.mainInformation)
            case .ingredients:
                ModifyComponentsView<Ingredient, ModifyIngredientView>(components: $recipe.ingredients)
            case .directions:
                ModifyComponentsView<Direction, ModifyDirectionView>(components: $recipe.directions)
            }
            Spacer()
        }
    }
    
    enum Selection {
        case main, ingredients, directions
    }
}

#Preview {
    @State var recipe = Recipe()
    return ModifyRecipeView(recipe: $recipe)
}
