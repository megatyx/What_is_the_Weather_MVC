//
//  ForcastRouteHandler.swift
//  What_is_the_Weather_Demo
//
//  Created by Tyler Wells on 3/14/19.
//  Copyright © 2019 Tyler Wells. All rights reserved.
//

import CoreLocation
import Foundation
extension APIHandler {
    static func get5DayForcast(city: City, zipCode: String? = nil, success: @escaping (ServerResponseInformation, [Forecast], City) -> Void, failure: @escaping (APIError?) -> Void) {

        // Build the base URL from our factory
        let urlFactory = URLFactory()
            .addString(Constants.API.Routes.Forecast.forecast, isPiped: true)
            .addQuery(key: Constants.API.Parameters.Keys.accessKey,
                      value: Constants.API.Parameters.accessKey)

        // Add our query params prioritizing cityID first -> coordinates -> city name -> zipcode
        if let cityID = city.id {
            urlFactory.addQuery(key: Constants.API.Parameters.Keys.id,
                                value: "\(cityID)")

        } else if let coordinates = city.coordinates {
            urlFactory.addQuery(key: Constants.API.Parameters.Keys.Coordinates.latitude,
                                value: String(coordinates.latitude))
            urlFactory.addQuery(key: Constants.API.Parameters.Keys.Coordinates.longitude,
                                value: String(coordinates.longitude))
        } else if let cityName = city.name {
            if let countryAbbr = city.countryName {
                urlFactory.addStringArraySeperatedByCommas(from: [cityName, countryAbbr],
                                                           queryKey: Constants.API.Parameters.Keys.genericQuery)
            } else {
                urlFactory.addQuery(key: Constants.API.Parameters.Keys.genericQuery,
                                    value: cityName)
            }
        } else if let zipCode = zipCode {
            if let countryAbbr = city.countryName {
                urlFactory.addStringArraySeperatedByCommas(from: [zipCode, countryAbbr],
                                                           queryKey: Constants.API.Parameters.Keys.zipCode)
            } else {
                urlFactory.addQuery(key: Constants.API.Parameters.Keys.zipCode,
                                    value: zipCode)
            }
        } else {
            failure(APIError.invalidParameters)
            return
        }

        do {
            let apiSession = APISession(url: try urlFactory.make())
            apiSession.getData(completion: {data in
                let decoder = JSONDecoder()
                do {
                    if let jsonDic = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        if let list = jsonDic?["list"] as? Array<[String: Any]> {
                            if let main = list[0]["main"] as? [String:Any] {
                                print(list)
                            }
                        }
                    }
                    let serverInformation = try decoder.decode(ServerResponseInformation.self, from: data)
                    let forecastWrapper = try decoder.decode(ForecastDecoderWrapper.self, from: data)
                    let city = try decoder.decode(City.self, from: data)
                    success(serverInformation, forecastWrapper.forecast, city)
                } catch let error as APIError {
                    print("\(error): \(error.description)")
                    failure(error)
                } catch {
                    print("\(error): \(error.localizedDescription)")
                    failure(error as? APIError)
                }
            }, failure: {failure($0)})
        } catch let error as APIError {
            failure(error)
        } catch {
            print(error.localizedDescription)
            failure(APIError.unknown)
        }
    }
}

