//
//  Container+ViewModels.swift
//  marvel
//
//  Created by Kagan Girgin on 1/28/22.
//

import Swinject
import SwinjectAutoregistration

extension Container {
    func registerViewModels() {
        autoregister(SplashViewModel.self, initializer: SplashViewModel.init)
        autoregister(HomeViewModel.self, initializer: HomeViewModel.init)
        autoregister(CharacterViewModel.self, initializer: CharacterViewModel.init)
        autoregister(FavoritesViewModel.self, initializer: FavoritesViewModel.init)
    }
}
