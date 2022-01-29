//
//  FavoritesTableViewSource.swift
//  marvel
//
//  Created by Kagan Girgin on 1/29/22.
//

import UIKit
import Unrealm

final class FavoritesTableViewSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var data: Unrealm.Results<CharacterResult>
    let delegate: FavoritesTableViewOutput
    
    init(data: Unrealm.Results<CharacterResult>, delegate: FavoritesTableViewOutput) {
        self.data = data
        self.delegate = delegate
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCharacterTableViewCell", for: indexPath) as! HomeCharacterTableViewCell
        cell.selectionStyle = .none
        cell.updateCell(data: data[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate.onCharacterTapped(character: data[indexPath.row])
    }
}
