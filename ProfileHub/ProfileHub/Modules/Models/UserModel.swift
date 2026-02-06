//
//  UserModel.swift
//  ProfileHub
//
//  Created by Santhosh G Patkar on 04/02/26.
//

struct User: Identifiable, Codable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let phone: String
    let address: Address
    let company: Company
}

struct Address: Codable {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geo: Geo
}

struct Geo: Codable {
    let lat: String
    let lng: String
}

struct Company: Codable {
    let name: String
    let catchPhrase: String
}
