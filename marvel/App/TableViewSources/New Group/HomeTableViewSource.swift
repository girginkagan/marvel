//
//  HomeTableViewSource.swift
//  marvel
//
//  Created by Kagan Girgin on 1/29/22.
//

import UIKit

final class HomeTableViewSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var data: [CharacterResult]
    let delegate: HomeTableViewOutput
    var loadMore = false
    var noMorePage = false
    var isLoadingList = false
    
    init(data: [CharacterResult], delegate: HomeTableViewOutput) {
        self.data = data
        self.delegate = delegate
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? data.count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCharacterTableViewCell", for: indexPath) as! HomeCharacterTableViewCell
            cell.selectionStyle = .none
            cell.updateCell(data: data[indexPath.row])
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LoadingTableViewCell", for: indexPath) as! LoadingTableViewCell
            cell.selectionStyle = .none
            cell.updateCell()
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            delegate.onCharacterTapped(character: data[indexPath.row])
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (((scrollView.contentOffset.y + scrollView.frame.size.height) > scrollView.contentSize.height) && !isLoadingList && !noMorePage && data.count > 29) {
            isLoadingList = true
            delegate.getNextPage()
        }
    }
}
