//
//  ContentView.swift
//  ToolbarProject
//
//  Created by Joe L Barr on 1/17/24.
//

import SwiftUI

struct ContentView: View {
    @State var isPresenting: Bool = false
    var body: some View {
        NavigationStack {
            Text("Initial View")
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button(action: {isPresenting = !isPresenting}, label: {Image(systemName: "gear")})
                    }
                }
                .sheet(isPresented: $isPresenting, content: {
                    NavigationStack {
                        Text("Settings Page")
                            .toolbar {
                                ToolbarItem {
                                    Button("Save") {}
                                }
                            }
                    }
                })
        }
    }
}

#Preview {
    ContentView()
}
