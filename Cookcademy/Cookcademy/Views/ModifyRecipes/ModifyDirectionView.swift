//
//  ModifyDirectionView.swift
//  Cookcademy
//
//  Created by Joe L Barr on 1/20/24.
//

import SwiftUI

struct ModifyDirectionView: ModifyComponentView {
    @Binding var direction: Direction
    let createAction: (Direction) -> Void
    
    init(component: Binding<Direction>, createAction: @escaping (Direction) -> Void) {
        self._direction = component
        self.createAction = createAction
    }
    
    @AppStorage("listBackgroundColor") private var listBackgroundColor = AppColor.background
    @AppStorage("listTextColor") private var listTextColor = AppColor.foreground
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Form {
            TextField("Direction Description", text: $direction.description)
                .listRowBackground(listBackgroundColor)
            Toggle("Optional", isOn: $direction.isOptional)
                .listRowBackground(listBackgroundColor)
            HStack {
                Spacer()
                Button("Save") {
                    createAction(direction)
                    dismiss()
                }
                Spacer()
            }.listRowBackground(listBackgroundColor)
        }.foregroundStyle(listTextColor)
    }
}

#Preview {
    @State var emptyDirection = Direction(description: "", isOptional: false)
    return ModifyDirectionView(component: $emptyDirection) { _ in return}
}
