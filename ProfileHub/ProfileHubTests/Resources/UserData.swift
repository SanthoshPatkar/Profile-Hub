//
//  userData.swift
//  ProfileHubTests
//
//  Created by Santhosh G Patkar on 04/02/26.
//

@testable import ProfileHub

extension User {
    static let mockUsers: [User] = [
        User(
            id: 1,
            name: "Leanne Graham",
            username: "Bret",
            email: "leanne@test.com",
            phone: "123",
            address: Address(
                street: "Street",
                suite: "Suite",
                city: "Chennai",
                zipcode: "600001",
                geo: Geo(lat: "0", lng: "0")
            ),
            company: Company(name: "Romaguera", catchPhrase: "Multi-layered")
        ),
        User(
            id: 2,
            name: "Ervin Howell",
            username: "Antonette",
            email: "ervin@test.com",
            phone: "456",
            address: Address(
                street: "Street",
                suite: "Suite",
                city: "Bangalore",
                zipcode: "560001",
                geo: Geo(lat: "0", lng: "0")
            ),
            company: Company(name: "Deckow", catchPhrase: "Proactive")
        )
    ]
}
