//
//  CarData.swift
//  CARFAX
//
//  Created by Ferrakkem Bhuiyan on 2020-08-30.
//  Copyright © 2020 Ferrakkem Bhuiyan. All rights reserved.
//

import Foundation

struct CarInfoResponse: Decodable {
    var listings: [CarInfoDetail]
}

struct CarInfoDetail: Decodable {
    var year: Int?
    var make: String?
    var model: String?
    var mileage: Int?
    var trim: String?
    var currentPrice: Int
    var dealer: Address
    var images: Images
}

struct Address: Decodable {
    var address: String
    var phone: String
}

struct Images: Decodable {
    var baseUrl: String
    var large : [String]
}

struct Large: Decodable{
    var large: String
}

struct FirstPhoto: Decodable {
    var large: String
    var medium: String
    var small: String
}






