//
//  APIConstants.swift
//  What_is_the_Weather_Demo
//
//  Created by Tyler Wells on 3/14/19.
//  Copyright © 2019 Tyler Wells. All rights reserved.
//

extension Constants {
    struct API {
        static let baseURL = "http://api.openweathermap.org/data/2.5/"
        struct Routes {
            static let forcast = "forecast"
            static let convert = "convert"
        }

        struct Parameters {
            static let accessKey = "aa27840b8f087ab41ef5e35558158842"

            struct Keys {
                static let accessKey = "APPID"
                static let genericQuery = "q"
                static let id = "id"
                static let zipCode = "zip"

                struct Coordinates {
                    static let longitude = "lon"
                    static let latitude = "lat"
                }
            }


        }

        struct JSONPayloadKeys {

            struct ServerSpecific {
                static let cod: StringLiteralType = "cod"
                static let message: StringLiteralType = "message"
            }
        }
    }
}
