//
//  TemperatureAndBarometrics.swift
//  What_is_the_Weather_Demo
//
//  Created by Tyler Wells on 3/15/19.
//  Copyright © 2019 Tyler Wells. All rights reserved.
//

import Foundation

struct TemperatureAndBarometrics {
    let temperature: TemperatureInformation
    let barometrics: BarometricsInformation
}

extension TemperatureAndBarometrics: Decodable {
    init(from decoder: Decoder) throws {
        self.temperature = try TemperatureInformation(from: decoder)
        self.barometrics = try BarometricsInformation(from: decoder)
    }
}
