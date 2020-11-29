//
//  SwingectManager.swift
//  Breweries
//
//  Created by vit on 29.11.2020.
//

import UIKit
import Swinject

final class SwinjectManager {
    
    private let assembler = Assembler([
        NetworkingAssembly(),
        BreweriesVCAssembly(),
    ])
    
    var mainVC: UIViewController? {
        return assembler.resolver.resolve(BreweriesViewController.self)
    }
}
