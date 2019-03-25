//
//  TemperatureInformation.swift
//  What_is_the_Weather_Demo
//
//  Created by Tyler Wells on 3/15/19.
//  Copyright © 2019 Tyler Wells. All rights reserved.
//

import Foundation

struct TemperatureInformation {
    let min_Kelvins: Double
    let max_Kelvins: Double
    let current_Kelvins: Double
    
    var min_Celsius: Double {
        return  self.convertToCelsius(tempKelvins: min_Kelvins)
    }
    
    var max_Celsius: Double {
        return  self.convertToCelsius(tempKelvins: max_Kelvins)
    }
    
    var current_Celsius: Double {
        return  self.convertToCelsius(tempKelvins: current_Kelvins)
    }
    
    var min_Fahrenheit: Double {
        return self.convertToFahrenheit(tempKelvins: min_Kelvins)
    }
    
    var max_Fahrenheit: Double {
        return self.convertToFahrenheit(tempKelvins: max_Kelvins)
    }
    
    var current_Fahrenheit: Double {
        return self.convertToFahrenheit(tempKelvins: current_Kelvins)
    }
    
    private func convertToCelsius(tempKelvins: Double) -> Double {
        return  tempKelvins - 273.15
        
    }
    private func convertToFahrenheit(tempKelvins: Double) -> Double {
        return (1.8 * (tempKelvins - 273.15) + 32)
    }
}

extension TemperatureInformation: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Constants.API.JSONPayloadKeys.ForecastCodingKeys.self)
        self.min_Kelvins = try container.decode(Double.self, forKey: .min)
        self.max_Kelvins = try container.decode(Double.self, forKey: .max)
        self.current_Kelvins = try container.decode(Double.self, forKey: .temperature)
    }
}
