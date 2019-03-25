//
//  WeatherStatusEnum.swift
//  What_is_the_Weather_Demo
//
//  Created by Tyler Wells on 3/15/19.
//  Copyright © 2019 Tyler Wells. All rights reserved.
//

import Foundation
import UIKit

enum WeatherStatusEnum: String {
    case cloudy = "Clouds"
    case clear = "Clear"
    case rain = "Rain"
    case snow = "Snow"
    
    var image: UIImage? {
        switch self {
        case .cloudy:
            return UIImage(named: "cloudyWeatherIcon")
        case .clear:
            return UIImage(named: "sunnyWeatherIcon")
        case .rain:
            return UIImage(named: "rainyWeathericon")
        case .snow:
            return UIImage(named: "snowWeatherIcon")
        }
    }
}
