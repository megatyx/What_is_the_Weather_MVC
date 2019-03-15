//
//  Coordinate.swift
//  What_is_the_Weather_Demo
//
//  Created by Tyler Wells on 3/15/19.
//  Copyright © 2019 Tyler Wells. All rights reserved.
//

import Foundation
import CoreLocation

enum ConversionError: Error {
    case dataStuctureParseFailed
}

struct Coordinate {
    let longitude: Double
    let latitude: Double

    func convertToCLCoordinate() throws -> CLLocationCoordinate2D {
        guard let long = CLLocationDegrees(exactly: self.longitude),
            let lat = CLLocationDegrees(exactly: self.longitude)
            else {throw ConversionError.dataStuctureParseFailed}
        return CLLocationCoordinate2D(latitude: long, longitude: lat)
    }
}

extension Coordinate: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Constants.API.JSONPayloadKeys.CityCodingKeys.self)
        self.longitude = try container.decode(Double.self, forKey: .longitude)
        self.latitude = try container.decode(Double.self, forKey: .latitude)
    }
}
