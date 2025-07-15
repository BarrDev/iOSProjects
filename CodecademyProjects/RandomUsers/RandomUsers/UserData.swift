//
//  UserData.swift
//  RandomUsersTests
//
//  Created by Joe L Barr on 2/6/24.
//

import Foundation

@MainActor
class UserData: ObservableObject {
    @Published var users: [User] = []
    
    init() {
        Task {
            await loadUsers()
        }
        
        func loadUsers() async {
            do {
                let users = try await UserFetchingClient.getUsers()
                self.users = users
            }
            
            catch {
                print(error)
            }
        }
    }
}
