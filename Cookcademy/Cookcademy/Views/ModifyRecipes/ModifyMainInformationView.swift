//
//  ModifyMainInformationView.swift
//  Cookcademy
//
//  Created by Joe L Barr on 1/18/24.
//

import SwiftUI
import Foundation

struct ModifyMainInformationView: View {
    @Binding var mainInformation: MainInformation
    
    @AppStorage("listBackgroundColor") private var listBackgroundColor = AppColor.background
    @AppStorage("listTextColor") private var listTextColor = AppColor.foreground
    
    var body: some View {
        Form {
            TextField("Recipe Name", text: $mainInformation.name)
                .listRowBackground(listBackgroundColor)
            
            TextField("Author", text: $mainInformation.author)
                .listRowBackground(listBackgroundColor)
            
            Section(content: {
                TextEditor(text: $mainInformation.description)
                    .listRowBackground(listBackgroundColor)
            }, header: { Text("Description")})
            
            Picker(selection: $mainInformation.category, label:
                    HStack {
                Text("Category")
                Spacer()
                Text(mainInformation.category.rawValue)
            }) {
                ForEach(MainInformation.Category.allCases, id: \.self) { category in
                    Text(category.rawValue)
                }
            }
            .listRowBackground(listBackgroundColor)
            .pickerStyle(MenuPickerStyle())
        }
        .foregroundStyle(listTextColor)
    }
}

#Preview {
    @State var test = MainInformation(name: "Pasta", description: "PASTA", author: "PasP", category: .breakfast)
    return ModifyMainInformationView(mainInformation: $test)
}
