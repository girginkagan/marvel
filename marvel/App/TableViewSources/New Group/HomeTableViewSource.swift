//
//  HomeTableViewSource.swift
//  marvel
//
//  Created by Kagan Girgin on 1/29/22.
//

import UIKit

final class HomeTableViewSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    let data: [CharacterResult]
    let delegate: HomeTableViewOutput
    
    init(data: [CharacterResult], delegate: HomeTableViewOutput) {
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
