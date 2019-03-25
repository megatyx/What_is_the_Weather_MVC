//
//  Forecast.swift
//  What_is_the_Weather_Demo
//
//  Created by Tyler Wells on 3/14/19.
//  Copyright © 2019 Tyler Wells. All rights reserved.
//

import Foundation

struct Forecast {
    let dt: Double
    let time: Date
    let temperatureDetails: TemperatureAndBarometrics
    let weather: [WeatherInformation]
    let clouds: Int
    let wind: WindInformation
}

extension Forecast: Decodable {
    init(from decoder: Decoder) throws {
        var container = try decoder.container(keyedBy: Constants.API.JSONPayloadKeys.ForecastCodingKeys.self)
        if let nestedContainer = try? container.nestedContainer(keyedBy: Constants.API.JSONPayloadKeys.ForecastCodingKeys.self,
                                                                forKey: .forcastsContainer) {
            container = nestedContainer
        }

        self.dt = try container.decode(Double.self, forKey: .dt)
        self.time = Date(timeIntervalSince1970: dt)
        self.temperatureDetails = try TemperatureAndBarometrics(from: decoder)
        self.weather = try container.decode([WeatherInformation].self, forKey: .weather)
        self.clouds = try container.decode(Int.self, forKey: .clouds)
        self.wind = try WindInformation(from: decoder)
    }
}
