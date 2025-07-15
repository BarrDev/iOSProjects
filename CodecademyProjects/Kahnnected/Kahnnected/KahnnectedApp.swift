//
//  KahnnectedApp.swift
//  Kahnnected
//
//  Created by Joe Barr on 6/21/23.
//

import SwiftUI
import Firebase

@main
struct KahnnectedApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            AuthView()
        }
    }
}
