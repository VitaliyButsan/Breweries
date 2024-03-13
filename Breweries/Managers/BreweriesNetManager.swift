//
//  NetworkManager.swift
//  Breweries
//
//  Created by vit on 24.11.2020.
//

import Foundation

protocol Networking: AnyObject {
    func request(callBack: @escaping(Data?, URLResponse?, Error?) -> Void)
}

class BreweriesNetManager: Networking {
    
    func request(callBack: @escaping(Data?, URLResponse?, Error?) -> Void) {
        let parameters = prepareParameters()
        let URL = url(params: parameters)
        var request = URLRequest(url: URL)
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
        components.host = "api.openbrewerydb.org"
        components.path = "/v1/breweries"
        components.queryItems = params.map { URLQueryItem(name: $0, value: $1) }
        return components.url!
    }

    private func createDataTask(from request: URLRequest, callBack: @escaping(Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                callBack(data, response, error)
            }
        }
    }
}
