//
//  UserFetchingClient.swift
//  RandomUsersTests
//
//  Created by Joe L Barr on 2/6/24.
//

import Foundation

struct UserFetchingClient {
    static private let url = URL(string: "https://randomuser.me/api/?results=10&format=pretty")!
    
    static func getUsers() async throws -> [User] {
       async let (data, _) = URLSession.shared.data(from: url) //Returns Data and URLResponse (metadata)
        let response = try await JSONDecoder().decode(Response.self, from: data)
        return response.users
    }
}
