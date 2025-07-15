//
//  ItemDetailView.swift
//  Navigation
//
//  Created by Joe L Barr on 1/13/24.
//

import SwiftUI

struct ItemDetailView: View {
    @State var quantityRemaining = Int.random(in: 1...10)
    let itemName: String
    var body: some View {
        NavigationStack {
            VStack {
                Text("\(itemName)")
                    .font(.title)
                    .padding()
                Spacer()
                Image(systemName: "photo")
                    .font(.system(size: 200))
                    .padding()
                Text("Quantity Remaining: \(quantityRemaining)")
                Spacer()
                Button {
                    if quantityRemaining > 0 {
                        quantityRemaining -= 1
                    }
                } label: {
                    Text("Add one to your cart")
                }
                Spacer()
            }
            .navigationDestination(isPresented: .constant(quantityRemaining == 0), destination: {Text("You bought all the \(itemName)!")})
        }
    }
}

#Preview {
    ItemDetailView(itemName: "Test Item")
}
