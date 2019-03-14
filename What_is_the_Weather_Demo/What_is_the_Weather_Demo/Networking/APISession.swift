//
//  APISession.swift
//  What_is_the_Weather_Demo
//
//  Created by Tyler Wells on 3/14/19.
//  Copyright © 2019 Tyler Wells. All rights reserved.
//

import Foundation

class APISession {
    let urlSession: URLSession
    var dataTask: URLSessionDataTask? = nil
    var url: URL?

    typealias SuccessData = (Data) -> Void
    typealias Failure = (APIError) -> Void
    typealias SuccessDic = ([String:Any]) -> Void

    init(urlSession: URLSession = URLSession(configuration: .default), url: URL? = nil, headers:[String:String]? = nil) {
        if let headers = headers {
            let config = URLSessionConfiguration.default
            config.httpAdditionalHeaders = headers
            self.urlSession = URLSession(configuration: config)
        } else {
            self.urlSession = urlSession
        }
        self.url = url
    }

    deinit {
        dataTask = nil
        url = nil
    }

    func cancelNetwork() {
        self.dataTask?.cancel()
    }

    private class func checkConnectivity() throws {
        if !Reachability.isConnectedToNetwork() {
            print("API_Error: Unreachable")
            throw APIError.unreachableInternetDisabled
        }
    }

    func getJSONDictionary(completion: @escaping SuccessDic, failure: @escaping Failure) {
        getData(completion: {data in
            do {
                if let jsonDic = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    DispatchQueue.main.async {
                        completion(jsonDic)
                    }
                } else {failure(APIError.dictionaryParse)}
            } catch {
                print(error.localizedDescription)
                failure(APIError.dictionaryParse)
            }
        }, failure: {failure($0)})
    }

    func getData(completion: @escaping SuccessData, failure: @escaping Failure) {
        cancelNetwork()
        do {
            try APISession.checkConnectivity()
        } catch  {
            guard let error = error as? APIError else {failure(APIError.unknown);return}
            failure(error)
            return
        }
        guard let url = url else {
            failure(APIError.urlCasting)
            print("API_FAILURE: Due to invalid URL")
            return
        }
        dataTask = urlSession.dataTask(with: url) {[weak self] data, response, error in
            defer { self?.cancelNetwork() }
            debugPrint("URL: \(url)")
            debugPrint("Data: \(String(describing: data))")
            debugPrint("Response: \(String(describing: response))")
            debugPrint("Error: \(String(describing: error))")
            if error != nil {
                DispatchQueue.main.async {
                    print(error?.localizedDescription as Any)
                    failure(APIError.unknown)
                }
                return
            }
            guard let response = response as? HTTPURLResponse else {
                DispatchQueue.main.async {failure(APIError.noResponse)}
                return
            }

            if 200 ... 299 ~= response.statusCode {
                if let data = data {
                    DispatchQueue.main.async {
                        completion(data)
                    }
                } else {DispatchQueue.main.async {failure(APIError.payloadParse)}}
            } else {
                DispatchQueue.main.async {failure(UnexpectedServerResponse.generateError(response.statusCode))}
                return
            }
        }
        dataTask?.resume()
    }
}

struct UnexpectedServerResponse {
    static func generateError(_ statusCode: Int) -> APIError {
        switch statusCode {
        case 200 ... 299:
            return(APIError.unknown200)
        case 300 ... 399:
            return(APIError.unknown300)
        case 400, 402:
            return(APIError.unknown400)
        case 401, 403:
            return(APIError.forbidden)
        case 404:
            return(APIError.notFound)
        case 405 ... 428:
            return (APIError.unknown400)
        case 429:
            return (APIError.blockedInExcess)
        case 430 ... 499:
            return (APIError.unknown400)
        case 500... :
            return(APIError.internalServerError)
        default:
            return(APIError.unknown)
        }
    }
}
