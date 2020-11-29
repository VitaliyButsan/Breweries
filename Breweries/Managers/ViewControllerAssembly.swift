//
//  ViewControllerAssembly.swift
//  Breweries
//
//  Created by vit on 29.11.2020.
//

import Swinject

final class BreweriesVCAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(BreweriesViewController.self) { resolver in
            return BreweriesViewController(viewModel: resolver.resolve(BreweriesViewModel.self)!)
        }
    }
}
