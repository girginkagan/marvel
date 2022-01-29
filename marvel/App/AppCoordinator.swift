//
//  AppCoordinator.swift
//  marvel
//
//  Created by Kagan Girgin on 1/28/22.
//

import UIKit

class AppCoordinator: BaseCoordinator {
    
    private var window = UIWindow(frame: UIScreen.main.bounds)
    
    override func start() {
        window.makeKeyAndVisible()
        presentSplash()
    }
    
    private func presentSplash() {
        removeChildCoordinators()
        
        let coordinator = AppDelegate.container.resolve(SplashCoordinator.self)!
        start(coordinator: coordinator)
        
        ViewControllerUtil.setRootViewController(
            window: window,
            viewController: coordinator.navigationController,
            withAnimation: true)
    }
    
    func presentHome() {
        removeChildCoordinators()
        
        let coordinator = AppDelegate.container.resolve(HomeCoordinator.self)!
        start(coordinator: coordinator)
        
        ViewControllerUtil.setRootViewController(
            window: window,
            viewController: coordinator.navigationController,
            withAnimation: true)
    }
}
