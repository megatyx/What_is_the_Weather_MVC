//
//  ParameterConstants.swift
//  What_is_the_Weather_Demo
//
//  Created by Tyler Wells on 3/15/19.
//  Copyright © 2019 Tyler Wells. All rights reserved.
//

import Foundation

extension Constants.API {
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
}
