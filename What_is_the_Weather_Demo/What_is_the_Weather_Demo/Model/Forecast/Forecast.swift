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
        let container = try decoder.container(keyedBy: Constants.API.JSONPayloadKeys.ForecastCodingKeys.self)

        //Get TimeStamp
        let dt = try container.decode(Double.self, forKey: .dt)
        self.dt = dt
        self.time = Date(timeIntervalSince1970: dt)
        
        // Check for clouds container due to inconsistant API returns
        if let nestedContainer = try? container.nestedContainer(keyedBy: Constants.API.JSONPayloadKeys.ForecastCodingKeys.self,
                                                                forKey: .clouds) {
            self.clouds = try nestedContainer.decode(Int.self, forKey: .all)
        } else {
            self.clouds = try container.decode(Int.self, forKey: .clouds)
        }
        
        self.temperatureDetails = try container.decode(TemperatureAndBarometrics.self, forKey: .mainWrapper)
        self.weather = try container.decode([WeatherInformation].self, forKey: .weather)
        self.wind = try container.decode(WindInformation.self, forKey: .wind)
    }
}
