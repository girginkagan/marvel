//
//  RealmUtil.swift
//  marvel
//
//  Created by Kagan Girgin on 1/29/22.
//

import RealmSwift
import Unrealm

final class RealmUtil {
    func setFavorite(data: CharacterResult) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(data, update: .all)
        }
    }
    
    func setUnFavorite(data: CharacterResult) {
        let realm = try! Realm()
        try! realm.write {
            realm.delete(data)
        }
    }
    
    func getFavorites() -> Unrealm.Results<CharacterResult>? {
        let realm = try! Realm()
        return realm.objects(CharacterResult.self)
    }

}
