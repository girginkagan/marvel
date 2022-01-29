//
//  Storyboarded.swift
//  marvel
//
//  Created by Kagan Girgin on 1/28/22.
//

import Foundation

protocol Storyboarded {
    static var storyboard: AppStoryboard { get }
    static func instantiate() -> Self
}

extension Storyboarded {
    static func instantiate() -> Self {
        let identifier = String(describing: self)
        switch identifier {
        case AppStoryboard.Splash.rawValue:
            let viewController = SplashViewController(nibName: identifier, bundle: nil) as! Self
            return viewController
        case AppStoryboard.Home.rawValue:
            let viewController = HomeViewController(nibName: identifier, bundle: nil) as! Self
            return viewController
        case AppStoryboard.Character.rawValue:
            let viewController = CharacterViewController(nibName: identifier, bundle: nil) as! Self
            return viewController
        default:
            let viewController = SplashViewController(nibName: identifier, bundle: nil) as! Self
            return viewController
        }
    }
}
