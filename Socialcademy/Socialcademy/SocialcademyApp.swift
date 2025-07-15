//
//  SocialcademyApp.swift
//  Socialcademy
//
//  Created by Joe L Barr on 3/10/24.
//

import SwiftUI
import Firebase

@main
struct SocialcademyApp: App {
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            PostsList()
        }
    }
}
