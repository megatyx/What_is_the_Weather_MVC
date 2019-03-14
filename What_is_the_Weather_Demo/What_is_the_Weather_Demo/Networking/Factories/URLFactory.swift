//
//  URLFactory.swift
//  What_is_the_Weather_Demo
//
//  Created by Tyler Wells on 3/14/19.
//  Copyright © 2019 Tyler Wells. All rights reserved.
//

import Foundation

class URLFactory {

    private var urlString: String

    init(baseURL: String = Constants.API.baseURL) {
        urlString = baseURL
    }

    func getUrlString() -> String {
        return urlString
    }

    public class func cleanseURL(urlString: String? = nil, uncleanURL: URL? = nil, encodedOnceBefore: Bool = false) -> URL? {
        guard let initialString = urlString ?? uncleanURL?.absoluteString else {return nil}
        let characterSet = generateURLCharacterSet(encodedOnceBefore)
        guard let encodedURLString = initialString.addingPercentEncoding(withAllowedCharacters: characterSet) else {return nil}
        return URL(string: encodedURLString)
    }

    public class func generateURLCharacterSet(_ encodedOnceBefore: Bool = false) -> CharacterSet {
        return (encodedOnceBefore) ? CharacterSet.alphanumerics
            .union(.urlHostAllowed)
            .union(.urlQueryAllowed)
            .subtracting(CharacterSet(charactersIn: "%&"))
            :CharacterSet.alphanumerics
                .union(.urlHostAllowed)
                .union(.urlQueryAllowed)
    }

    func make() throws -> URL {
        guard let url = URL(string: urlString) else {throw APIError.urlCasting}
        return url
    }

    @discardableResult
    func addQuery(key: String, value: String) -> URLFactory {
        if let keyString =  (key + "=").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let valueString = value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            if !urlString.contains("?") {
                self.urlString += "?"
            }
            if urlString.last != "?" {
                self.urlString += "&"
            }
            self.urlString += keyString + valueString
        }
        return self
    }

    @discardableResult
    func addString(_ someString: String, isPiped: Bool = false) -> URLFactory {
        self.urlString += (isPiped ? "\(someString)/":"\(someString)")
        return self
    }

    @discardableResult
    func addStringArraySeperatedByCommas(from stringArray: [String], queryKey: String? = nil) -> URLFactory {
        let stringFromArray = self.generateStringSeperatedByCommas(from: stringArray)

        // If we are passed a queryKey, then we know to treat the string array as a query rather than a normal string
        if let queryKey = queryKey, queryKey.count > 0 {
            return self.addQuery(key: queryKey,
                          value: stringFromArray)
        } else {
            urlString += stringFromArray
            return self
        }
    }

    private func generateStringSeperatedByCommas(from stringArray: [String]) -> String {
        var generatedString = ""
        for string in stringArray {
            generatedString += string
            if string != stringArray.last {
                generatedString += ","
            }
        }
        return generatedString
    }
}
