//
//  CharacterCoordinator.swift
//  marvel
//
//  Created by Kagan Girgin on 1/29/22.
//

import UIKit

class CharacterCoordinator: BaseCoordinator {
    private let viewModel: CharacterViewModel
    
    init(viewModel: CharacterViewModel) {
        self.viewModel = viewModel
    }
    
    override func start() {
        let viewController = CharacterViewController.instantiate()
        viewModel.coordinator = self
        viewController.viewModel = viewModel
        
        parentCoordinator?.navigationController.pushViewController(viewController, animated: true)
    }
}
