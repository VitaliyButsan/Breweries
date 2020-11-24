//
//  BreweriesViewModel.swift
//  Breweries
//
//  Created by vit on 24.11.2020.
//

import Foundation

enum NetError: Error {
    case responseError
    case parseError
}

class BreweriesViewModel {
    
    var breweries: [Brewery] = []
    
    func getBreweries() {
        NetworkManager.shared.request { data, response, _ in
            if let response = (response as? HTTPURLResponse), (200...299).contains(response.statusCode) {
                print("Success with status code: \(response.statusCode)")
            } else {
                self.sendNotification(name: .failure)
                print(NetError.responseError)
                return
            }
            guard let data = data else { return }
            guard let results: [Brewery] = self.parse(data: data) else {
                print(NetError.parseError)
                return
            }
            self.breweries = results
            self.sendNotification(name: .complete)
        }
    }
    
    private func sendNotification(name: Notification.Name) {
        NotificationCenter.default.post(name: name, object: self)
    }
    
    private func parse<T: Decodable>(data: Data) -> [T]? {
        do {
            return try JSONDecoder().decode([T].self, from: data)
        } catch {
            return nil
        }
    }
}
