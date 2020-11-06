//
//  Product.swift
//  dolap-ios-case-study
//
//  Created by Emre Çelik on 5.11.2020.
//

import Foundation

struct Price: Codable {
    let value: Int
    let currency: String
}

struct Product: Codable {
    let id: Int
    let name: String
    let desc: String
    let image: String
    let price: Price
}

// CodingKeys can be added
