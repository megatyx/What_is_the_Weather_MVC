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
    func getForcast(cityID: String? = nil, cityName: String? = nil, zipCode: String? = nil, countryAbbr: String? = nil, coordinates: CLLocationCoordinate2D? = nil,  success: @escaping () -> Void, failure: @escaping (APIError?) -> Void) {

        // Build the base URL from our factory
        let urlFactory = URLFactory()
            .addString(Constants.API.Routes.forcast)
            .addQuery(key: Constants.API.Parameters.Keys.accessKey,
                      value: Constants.API.Parameters.accessKey)

        // Add our query params prioritizing cityID first -> coordinates -> city name -> zipcode
        if let cityID = cityID {
            urlFactory.addQuery(key: Constants.API.Parameters.Keys.id,
                                value: cityID)

        } else if let coordinates = coordinates {
            urlFactory.addQuery(key: Constants.API.Parameters.Keys.Coordinates.latitude,
                                value: String(coordinates.latitude))
            urlFactory.addQuery(key: Constants.API.Parameters.Keys.Coordinates.longitude,
                                value: String(coordinates.longitude))
        } else if let cityName = cityName {
            if let countryAbbr = countryAbbr {
                urlFactory.addStringArraySeperatedByCommas(from: [cityName, countryAbbr],
                                                           queryKey: Constants.API.Parameters.Keys.genericQuery)
            } else {
                urlFactory.addQuery(key: Constants.API.Parameters.Keys.genericQuery,
                                    value: cityName)
            }
        } else if let zipCode = zipCode {
            if let countryAbbr = countryAbbr {
                urlFactory.addStringArraySeperatedByCommas(from: [zipCode, countryAbbr],
                                                           queryKey: Constants.API.Parameters.Keys.zipCode)
            } else {
                urlFactory.addQuery(key: Constants.API.Parameters.Keys.zipCode,
                                    value: zipCode)
            }
        }

        do {
            let apiSession = APISession(url: try urlFactory.make())
            apiSession.getData(completion: {data in
                let decoder = JSONDecoder()
                do {
                    let serverData = try decoder.decode(ServerResponseInformation.self, from: data)

                    if let isSuccess = serverData.isSuccess, isSuccess {
                        let rates = try decoder.decode(CurrencyRates.self, from: data)
                        var baseCurrency: String? = base
                        if let jsonDic = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                            let newBaseCurrency =  jsonDic?["base"] as? String {
                            baseCurrency = newBaseCurrency
                        }
                        success(baseCurrency, rates)
                    } else {
                        failure(APIError.unsuccessfulPayload)
                    }
                } catch let error as APIError {
                    print(error.description)
                    failure(error)
                } catch {
                    print(error.localizedDescription)
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

