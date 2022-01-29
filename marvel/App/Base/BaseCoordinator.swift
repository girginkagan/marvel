//
//  BaseCoordinator.swift
//  marvel
//
//  Created by Kagan Girgin on 1/28/22.
//

import UIKit
import RxSwift

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    var parentCoordinator: Coordinator? { get set }
    
    func start()
    func start(coordinator: Coordinator)
    func didFinish(coordinator: Coordinator)
    func removeChildCoordinators()
}

class BaseCoordinator: Coordinator {
    var navigationController = UINavigationController()
    var childCoordinators = [Coordinator]()
    var parentCoordinator: Coordinator?
    private var disposeBag = DisposeBag()
    
    init() {
        navigationController.rx.willShow.subscribe { event in
            let item = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
            event.element?.viewController.navigationItem.backBarButtonItem = item
        }.disposed(by: disposeBag)
    }
    
    func start() {
        fatalError("Start method should be implemented.")
    }
    
    func start(coordinator: Coordinator) {
        childCoordinators += [coordinator]
        coordinator.parentCoordinator = self
        coordinator.start()
    }
    
    func removeChildCoordinators() {
        childCoordinators.forEach { $0.removeChildCoordinators() }
        childCoordinators.removeAll()
    }
    
    func didFinish(coordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(where: { $0 === coordinator }) {
            childCoordinators.remove(at: index)
        }
    }
}

