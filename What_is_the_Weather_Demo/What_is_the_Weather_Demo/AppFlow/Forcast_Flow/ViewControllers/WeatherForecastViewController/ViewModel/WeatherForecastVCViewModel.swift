//
//  WeatherForecastVCViewModel.swift
//  What_is_the_Weather_Demo
//
//  Created by Tyler Wells on 3/26/19.
//  Copyright © 2019 Tyler Wells. All rights reserved.
//

import Foundation

struct WeatherForecastVCViewModel {
    
    struct ForecastDisplayInformation {
        var sectionName: String
        var sectionData: [WeatherInformationViewModel]
    }
    
    var dataArray = [ForecastDisplayInformation]()
    
    var dataReference = [Forecast]()
    
    var dateFormatter = DateFormatter() {
        didSet {
            dateFormatter.dateFormat = "yyyy-MM-dd"
        }
    }
    var timeFormatter = DateFormatter() {
        didSet {
            timeFormatter.dateFormat = "HH:mm"
        }
    }
    
    func getForecastData(success: @escaping ([ForecastDisplayInformation]) -> Void, failure: @escaping (APIError?) -> Void) {
        APIHandler.get5DayForcast(city: City(id: 420037612), success: {_, forecastArray,_ in
            var newData = [ForecastDisplayInformation]()
            for forecast in forecastArray {
                let potentialSectionName = self.dateFormatter.string(from: forecast.time)
                let weatherInformation = WeatherInformationViewModel(weatherIcon: forecast.weather[0].weatherStatus?.image,
                                                                     weatherDescription: forecast.weather[0].weatherStatusDetail,
                                                                     timeString: self.timeFormatter.string(from: forecast.time),
                                                                     temperatureString: "\(lround(forecast.temperatureDetails.temperature.current_Celsius))°",
                    timeDate: forecast.time)
                if let sectionIndex = newData.firstIndex(where: {$0.sectionName == potentialSectionName}) {
                    newData[sectionIndex].sectionData.append(weatherInformation)
                } else {
                    newData.append(ForecastDisplayInformation(sectionName: potentialSectionName, sectionData: [weatherInformation]))
                }
            }
            success(newData.sorted(by: {$0.sectionData[0].timeDate.compare($1.sectionData[0].timeDate) == .orderedAscending}))
        }, failure: {failure($0)})
    }
    
    func lookupDataByViewModel(weatherVM: WeatherInformationViewModel) -> Forecast? {
        return self.dataReference.first(where: {$0.time == weatherVM.timeDate})
    }
}
