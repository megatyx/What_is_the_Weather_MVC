//
//  Forecast.swift
//  What_is_the_Weather_Demo
//
//  Created by Tyler Wells on 3/15/19.
//  Copyright © 2019 Tyler Wells. All rights reserved.
//

import Foundation

struct Forecast {
    let forecastDays: [ForecastDay]
}

extension Forecast: Decodable {
    fileprivate enum CodingKeys: String, CodingKey {
        case forecastDays = "list"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.forecastDays = try container.decode([ForecastDay].self, forKey: .forecastDays)
    }
}