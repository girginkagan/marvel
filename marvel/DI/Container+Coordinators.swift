//
//  Container+Coordinators.swift
//  marvel
//
//  Created by Kagan Girgin on 1/28/22.
//

import Swinject
import SwinjectAutoregistration

extension Container {
    func registerCoordinators() {
        autoregister(AppCoordinator.self, initializer: AppCoordinator.init)
        autoregister(SplashCoordinator.self, initializer: SplashCoordinator.init)
        autoregister(HomeCoordinator.self, initializer: HomeCoordinator.init)
        autoregister(CharacterCoordinator.self, initializer: CharacterCoordinator.init)
        autoregister(FavoritesCoordinator.self, initializer: FavoritesCoordinator.init)
    }
}
