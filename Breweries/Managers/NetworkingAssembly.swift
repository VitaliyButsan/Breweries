//
//  BreweriesNetworkingAssembly.swift
//  Breweries
//
//  Created by vit on 29.11.2020.
//

import Swinject

final class NetworkingAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(Networking.self) { _ in BreweriesNetManager.shared }
        container.register(BreweriesViewModel.self) { resolver in
            return BreweriesViewModel(networkManager: resolver.resolve(Networking.self)!)
        }
    }
}
