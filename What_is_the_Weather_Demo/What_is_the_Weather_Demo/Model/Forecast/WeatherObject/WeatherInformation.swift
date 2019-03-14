//
//  WeatherInformation.swift
//  What_is_the_Weather_Demo
//
//  Created by Tyler Wells on 3/15/19.
//  Copyright © 2019 Tyler Wells. All rights reserved.
//

import Foundation

struct WeatherInformation {
    let id: Int
    let weatherStatus: WeatherStatusEnum?
    let weatherStatusDetail: String
}

extension WeatherInformation: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Constants.API.JSONPayloadKeys.ForecastCodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.weatherStatusDetail = try container.decode(String.self, forKey: .weatherStatusDetail)
        let weatherStatusString = try container.decode(String.self, forKey: .weatherStatus)
        self.weatherStatus = WeatherStatusEnum(rawValue: weatherStatusString)
    }
}
