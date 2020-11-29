//
//  BreweriesNetworkingAssembly.swift
//  Breweries
//
//  Created by vit on 29.11.2020.
//

import Swinject

final class BreweriesViewModelAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(BreweriesViewModel.self) { r in
            let networkManager = r.resolve(BreweriesNetManager.self)
            return BreweriesViewModel(networkManager: networkManager)
        }
    }
}
