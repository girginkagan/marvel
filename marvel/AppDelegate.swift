//
//  AppDelegate.swift
//  marvel
//
//  Created by Kagan Girgin on 1/28/22.
//

import UIKit
import Swinject
import RxCocoa
import SVProgressHUD
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    private var appCoordinator: AppCoordinator!
    static let container = Container()
    
    var resultCharacters = BehaviorRelay<CharactersResponseModel?>(value: nil)
    
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.setForegroundColor(.white)
        SVProgressHUD.setBackgroundColor(UIColor(red: 0, green: 0, blue: 0, alpha: 0.3))
        SVProgressHUD.setBackgroundLayerColor(UIColor(red: 0, green: 0, blue: 0, alpha: 0.2))
        
        AppDelegate.container.registerDependencies()
        FirebaseApp.configure()
        
        appCoordinator = AppDelegate.container.resolve(AppCoordinator.self)!
        appCoordinator.start()
        
        return true
    }
}

