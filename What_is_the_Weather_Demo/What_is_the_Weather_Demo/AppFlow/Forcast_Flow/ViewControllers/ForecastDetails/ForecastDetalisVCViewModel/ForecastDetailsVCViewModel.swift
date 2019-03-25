//
//  ForecastDetailsVCViewModel.swift
//  What_is_the_Weather_Demo
//
//  Created by Tyler Wells on 3/24/19.
//  Copyright © 2019 Tyler Wells. All rights reserved.
//

import Foundation

struct ForecastDetailsVCViewModel {
    let data: ForecastDay
    var rowsToDisplay: Int

    let temperatureRow: Int
    let weatherRow: Int
    let humidityRow: Int
    let pressureRow: Int
    let windSpeedRow: Int
    let windDirectionRow: Int

    
    init(data: ForecastDay) {
        self.data = data
        var runningRowCount = 0
        if data.weather.count > 0 {
            self.weatherRow = runningRowCount
            runningRowCount += 1
        } else {
            self.weatherRow = -1
        }
        
        self.temperatureRow = runningRowCount
        runningRowCount += 1

        self.humidityRow = runningRowCount
        runningRowCount += 1
        
        self.pressureRow = runningRowCount
        runningRowCount += 1

        self.windSpeedRow = runningRowCount
        runningRowCount += 1

        self.windDirectionRow = runningRowCount
        runningRowCount += 1

        self.rowsToDisplay = runningRowCount
    }
}
