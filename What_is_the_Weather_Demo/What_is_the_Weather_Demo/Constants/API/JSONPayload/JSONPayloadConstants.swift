//
//  JSONPayloadConstants.swift
//  What_is_the_Weather_Demo
//
//  Created by Tyler Wells on 3/15/19.
//  Copyright © 2019 Tyler Wells. All rights reserved.
//

import Foundation

extension Constants.API {
    struct JSONPayloadKeys {
        
        enum ServerCodingKeys: String, CodingKey {
            case code = "cod"
            case message = "message"
        }

        enum CityCodingKeys: String, CodingKey {
            case cityContainer = "city"
            case cityName = "name"
            case id = "id"
            case coordinate = "coord"
            case longitude = "lon"
            case latitude = "lat"
            case country = "country"
        }
        
        enum ForecastCodingKeys: String, CodingKey {
            case forcastsContainer = "list"
            case temperature = "temp"
            case day = "day"
            case min = "min"
            case max = "max"
            case night = "night"
            case eve = "eve"
            case morn = "morn"
            case pressure = "pressure"
            case humidity = "humidity"
            case id = "id"
            case weatherStatus = "main"
            case weatherStatusDetail = "description"
            case dt = "dt"
            case weather = "weather"
            case clouds = "clouds"
            case wind = "wind"
        }
    }
}
