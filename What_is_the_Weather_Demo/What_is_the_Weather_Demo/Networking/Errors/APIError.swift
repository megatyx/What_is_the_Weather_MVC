//
//  APIError.swift
//  What_is_the_Weather_Demo
//
//  Created by Tyler Wells on 3/14/19.
//  Copyright © 2019 Tyler Wells. All rights reserved.
//

import Foundation

enum APIError: Error, CustomStringConvertible {

    //Generics
    case unknown
    case urlCasting
    case invalidParameters

    //Data Specific
    case payloadParse
    case dictionaryParse
    case dataParseInvalidTimeStamp
    case unsuccessfulPayload

    //Response Specific
    case unknown200
    case unknown300
    case unknown400
    case unknown500
    case internalServerError
    case notFound
    case noResponse
    case forbidden

    //Device Specific
    case unreachableInternetDisabled

    //Weather API Specific
    case blockedInExcess

    var description: String {
        switch self {
        case .unknown, .unknown200, .unknown300, .unknown400, .unknown500:
            return "Unknown Error"
        case .payloadParse:
            return "JSON payload from the server couldn't be parsed into specified data stucture"
        case .dictionaryParse:
            return "JSON payload could not conform to Dicionary -> [String:Any]"
        case .internalServerError:
            return "Internal Server Error"
        case .notFound:
            return "Not Found"
        case .noResponse:
            return "Server Unreachable"
        case .forbidden:
            return "Forbidden"
        case .urlCasting:
            return "Unable to cast URL correctly"
        case .unreachableInternetDisabled:
            return "Network call unreachable due to device internet settings being disabled"
        case .dataParseInvalidTimeStamp:
            return "Timestamp is missing or improperly parsed"
        case .unsuccessfulPayload:
            return "JSON payload indicates failure in the return"
        case .invalidParameters:
            return "Invalid parameters passed to the API function"
        case .blockedInExcess:
            return "Your account is temporary blocked due to exceeding of requests limitation of your subscription type. Please choose the proper subscription http://openweathermap.org/price"
        }
    }
}
