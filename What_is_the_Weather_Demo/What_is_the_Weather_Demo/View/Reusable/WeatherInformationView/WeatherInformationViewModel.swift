//
//  WeatherInformationViewModel.swift
//  What_is_the_Weather_Demo
//
//  Created by Tyler Wells on 3/24/19.
//  Copyright © 2019 Tyler Wells. All rights reserved.
//

import Foundation
import UIKit

struct WeatherInformationViewModel {
    let weatherIcon: UIImage?
    let weatherDescription: String
    
    
    init(weatherInformation: WeatherInformation) {
        self.weatherIcon = weatherInformation.weatherStatus?.image
        self.weatherDescription = weatherInformation.weatherStatusDetail
    }
}
