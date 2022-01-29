//
//  HomeCoordinator.swift
//  marvel
//
//  Created by Kagan Girgin on 1/28/22.
//

import UIKit

class HomeCoordinator: BaseCoordinator {
    private let viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
    
    override func start() {
        let viewController = HomeViewController.instantiate()
        viewModel.coordinator = self
        viewController.viewModel = viewModel
        
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.tintColor = UIColor(named: "AccentColor")
        navigationController.viewControllers = [viewController]
    }
    
    func presentCharacterDetail(character: CharacterResult) {
        let coordinator = AppDelegate.container.resolve(CharacterCoordinator.self)!
        start(coordinator: coordinator)
        (navigationController.viewControllers.last as? CharacterViewController)?.data = character
    }
}
