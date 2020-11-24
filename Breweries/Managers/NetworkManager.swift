//
//  NetworkManager.swift
//  Breweries
//
//  Created by vit on 24.11.2020.
//

import Foundation

class NetworkManager {
    
    public static let shared = NetworkManager()
    
    private init() { }
    
    func request(callBack: @escaping(Data?, URLResponse?, Error?) -> Void) {
        let parameters = prepareParameters()
        let URL = url(params: parameters)
        var request = URLRequest(url: URL)
        request.allHTTPHeaderFields = prepareHeaders()
        request.httpMethod = "GET"
        let task = createDataTask(from: request, callBack: callBack)
        task.resume()
    }
    
    private func prepareParameters() -> [String: String] {
        var parameters = [String: String]()
        parameters["by_name"] = "cooper"
        return parameters
    }
    
    private func url(params: [String: String]) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "brianiswu-open-brewery-db-v1.p.rapidapi.com"
        components.path = "/breweries"
        components.queryItems = params.map { URLQueryItem(name: $0, value: $1) }
        return components.url!
    }
    
    private func prepareHeaders() -> [String: String] {
        var headers = [String: String]()
        headers["x-rapidapi-key"] = "1f189416abmsh23eaf7a1e65d0bbp15684fjsn554ed11ee227"
        headers["x-rapidapi-host"] = "brianiswu-open-brewery-db-v1.p.rapidapi.com"
        return headers
    }
    
    private func createDataTask(from request: URLRequest, callBack: @escaping(Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                callBack(data, response, error)
            }
        }
    }
}
