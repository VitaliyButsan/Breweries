//
//  NetworkManagerAssembly.swift
//  Breweries
//
//  Created by vit on 29.11.2020.
//

import Swinject

final class BreweriesNetManagerAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(BreweriesNetManager.self) { r in
            return BreweriesNetManager()
        }
    }
}
