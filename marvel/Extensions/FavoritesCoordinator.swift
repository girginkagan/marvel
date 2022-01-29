//
//  FavoritesCoordinator.swift
//  marvel
//
//  Created by Kagan Girgin on 1/29/22.
//

import UIKit

class FavoritesCoordinator: BaseCoordinator {
    private let viewModel: FavoritesViewModel
    
    init(viewModel: FavoritesViewModel) {
        self.viewModel = viewModel
    }
    
    override func start() {
        let viewController = FavoritesViewController.instantiate()
        viewModel.coordinator = self
        viewController.viewModel = viewModel
        
        parentCoordinator?.navigationController.pushViewController(viewController, animated: true)
    }
    
    func presentCharacterDetail(character: CharacterResult) {
        let coordinator = AppDelegate.container.resolve(CharacterCoordinator.self)!
        parentCoordinator?.start(coordinator: coordinator)
        (parentCoordinator?.navigationController.viewControllers.last as? CharacterViewController)?.data = character
    }
}
