//
//  ContentView.swift
//  TabViewProject
//
//  Created by Joe L Barr on 1/20/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Text("Home View")
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            Text("Profile View")
                .tabItem {
                    Label("Profile", systemImage: "person.circle.fill")
                }
        }
        .tabViewStyle(DefaultTabViewStyle())
    }
}

#Preview {
    ContentView()
}
