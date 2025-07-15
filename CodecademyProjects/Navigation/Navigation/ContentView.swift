//
//  ContentView.swift
//  Navigation
//
//  Created by Joe L Barr on 1/13/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack{
            VStack {
                Text("Items in Stock")
                    .font(.title)
                    .padding()
                Spacer()
                NavigationLink(destination: ItemDetailView(itemName: "Shrimp Chips"), label: { Text("Shrimp Chips") })
                Spacer()
            }
            .navigationTitle(Text("Ligaya's Store"))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
#Preview {
    ContentView()
}
