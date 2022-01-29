//
//  BaseViewModel.swift
//  marvel
//
//  Created by Kagan Girgin on 1/28/22.
//

import UIKit

class BaseViewModel {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let realmUtl = RealmUtil()
    
    init() {
        appDelegate.resultFavorites.accept(realmUtl.getFavorites())
    }
}
