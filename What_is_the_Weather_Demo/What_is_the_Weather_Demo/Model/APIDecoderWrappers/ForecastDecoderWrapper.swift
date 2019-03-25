//
//  ForecastDecoderWrapper.swift
//  What_is_the_Weather_Demo
//
//  Created by Tyler Wells on 3/25/19.
//  Copyright © 2019 Tyler Wells. All rights reserved.
//

import Foundation

struct ForecastDecoderWrapper {
    let forecast: [Forecast]
}

extension ForecastDecoderWrapper: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Constants.API.JSONPayloadKeys.ForecastCodingKeys.self)
        self.forecast = try container.decode([Forecast].self, forKey: .forcastsContainer)
    }
}
