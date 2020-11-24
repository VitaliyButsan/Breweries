//
//  Brewery.swift
//  Breweries
//
//  Created by vit on 24.11.2020.
//

import Foundation

struct Brewery: Decodable {
    let id: Int?
    let name: String?
    let breweryType: String?
    let street: String?
    let city: String?
    let state: String?
    let country: String?
    let phone: String?
    let websiteURL: String?
    let createdAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case breweryType = "brewery_type"
        case street
        case city
        case state
        case country
        case phone
        case websiteURL = "website_url"
        case createdAt = "created_at"
    }
}
