//
//  Container+Services.swift
//  marvel
//
//  Created by Kagan Girgin on 1/28/22.
//

import Swinject
import SwinjectAutoregistration

extension Container {
    func registerServices() {
        autoregister(RestClient.self, initializer: RestClient.init).inObjectScope(.container)
    }
}
