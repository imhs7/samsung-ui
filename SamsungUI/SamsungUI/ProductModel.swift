//
//  ProductModel.swift
//  SamsungUI
//
//  Created by Hemant Sharma on 03/08/21.
//

import Foundation

struct ResponseObject: Decodable {
    let code: Int?
    let status: String?
    let data: Products?
}

struct Products: Codable {
    let products: [Product]?
}

struct Product: Codable {
    let name: String?
    let price: Price?
    let images: [String]?
}

struct Price: Codable {
    let priceDisplay: String?
    let offerPriceDisplay: String?
}
