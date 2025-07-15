//
//  User.swift
//  RandomUsers
//
//  Created by Joe L Barr on 3/9/24.
//

import Foundation
/*
 {
   "results": [
     {
       "gender": "male",
       "name": {
         "title": "Mr",
         "first": "Ryan",
         "last": "Gulliksen"
       },
       "location": {
         "street": {
           "number": 8568,
           "name": "Doktor Londons vei"
         },
         "city": "Ogna",
         "state": "Bergen",
         "country": "Norway",
         "postcode": "3612",
         "coordinates": {
           "latitude": "49.9127",
           "longitude": "-96.4097"
         },
         "timezone": {
           "offset": "+5:45",
           "description": "Kathmandu"
         }
       },
       "email": "ryan.gulliksen@example.com",
       "login": {
         "uuid": "c4bd2921-d848-45aa-8776-9ee704729de7",
         "username": "heavygoose636",
         "password": "janelle",
         "salt": "2HrGvPNr",
         "md5": "87e36d0bb00d1a688708fcbb80174121",
         "sha1": "4314d4c1ef032ce44b2206365d82e8d177887904",
         "sha256": "c01cc1e08c0b599d5d98b2db95e2159ab1b9f400a2e6b828421914448769b5d1"
       },
       "dob": {
         "date": "1994-01-05T10:28:47.825Z",
         "age": 27
       },
       "registered": {
         "date": "2018-06-18T11:03:33.482Z",
         "age": 3
       },
       "phone": "22415884",
       "cell": "42672877",
       "id": {
         "name": "FN",
         "value": "05019415114"
       },
       "picture": {
         "large": "https://randomuser.me/api/portraits/men/45.jpg",
         "medium": "https://randomuser.me/api/portraits/med/men/45.jpg",
         "thumbnail": "https://randomuser.me/api/portraits/thumb/men/45.jpg"
       },
       "nat": "NO"
     }
 }
 */
struct Response: Decodable {
    let users: [User]
    
    enum CodingKeys: String, CodingKey {
        case users = "results"
    }
}

struct User: Decodable, Identifiable {
    let id: String
    let name: Name
    let picture: Picture
    
    var fullName: String {
        "\(name.title). \(name.first) \(name.last)"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(Name.self, forKey: .name)
        picture = try values.decode(Picture.self, forKey: .picture)
        let loginInfo = try values.nestedContainer(keyedBy: LoginInfoCodingKeys.self, forKey: .login)
        id = try loginInfo.decode(String.self, forKey: .uuid)
    }
    
    enum CodingKeys: String, CodingKey {
        case login
        case name
        case picture
    }
    
    enum LoginInfoCodingKeys: String, CodingKey {
        case uuid
    }
}

struct Name: Decodable {
    let title: String
    let first: String
    let last: String
}

struct Picture: Decodable {
    let large: String
    let medium: String
    let thumbnail: String
}
