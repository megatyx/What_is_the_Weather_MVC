//
//  ForecastDay.swift
//  What_is_the_Weather_Demo
//
//  Created by Tyler Wells on 3/14/19.
//  Copyright © 2019 Tyler Wells. All rights reserved.
//

import Foundation

struct ForecastDay {
    let dt: Int
    let temperatureDetails: TemperatureAndBarometrics
    let weather: [WeatherInformation]
    let clouds: Int
    let wind: WindInformation
}

extension ForecastDay: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Constants.API.JSONPayloadKeys.ForecastCodingKeys.self)
        self.dt = try container.decode(Int.self, forKey: .dt)
        self.temperatureDetails = try TemperatureAndBarometrics(from: decoder)
        self.weather = try container.decode([WeatherInformation].self, forKey: .weather)
        self.clouds = try container.decode(Int.self, forKey: .clouds)
        self.wind = try WindInformation(from: decoder)
    }
}
