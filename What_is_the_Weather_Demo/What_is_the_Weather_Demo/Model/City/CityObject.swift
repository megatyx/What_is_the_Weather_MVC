//
//  CityObject.swift
//  What_is_the_Weather_Demo
//
//  Created by Tyler Wells on 3/15/19.
//  Copyright © 2019 Tyler Wells. All rights reserved.
//

import Foundation

struct City {
    let id: Int?
    let name: String?
    let coordinates: Coordinate?
    let countryName: String?
    
    init(id: Int? = nil, name: String? = nil, coordinates: Coordinate? = nil, countryName: String? = nil) {
        self.id = id
        self.name = name
        self.coordinates = coordinates
        self.countryName = countryName
    }
}

extension City: Decodable {
    init(from decoder: Decoder) throws {
        var container = try decoder.container(keyedBy: Constants.API.JSONPayloadKeys.CityCodingKeys.self)
        if let nestedContainer = try? container.nestedContainer(keyedBy: Constants.API.JSONPayloadKeys.CityCodingKeys.self,
                                                                forKey: .cityContainer) {
            container = nestedContainer
        }
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .cityName)
        self.coordinates = try container.decode(Coordinate.self, forKey: .coordinate)
        self.countryName = try container.decode(String.self, forKey: .country)
    }
}
