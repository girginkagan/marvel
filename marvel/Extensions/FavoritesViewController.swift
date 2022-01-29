//
//  FavoritesViewController.swift
//  marvel
//
//  Created by Kagan Girgin on 1/29/22.
//

import UIKit
import RxSwift

class FavoritesViewController: UIViewController, Storyboarded {
    @IBOutlet weak var tableView: UITableView!
    
    static var storyboard = AppStoryboard.Favorites
    var viewModel: FavoritesViewModel?
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setBindings()
    }
    
    private func setUI() {
        navigationItem.title = "Favorites"
        tableView.register(UINib(nibName: "HomeCharacterTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeCharacterTableViewCell")
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 20, right: 0)
    }
    
    private func setBindings() {
        guard let viewModel = viewModel else { return }
        
        viewModel.setBindings(tableViewInputDelegate: self)
    }
}

extension FavoritesViewController: FavoritesTableViewInput {
    func onReloadTableView() {
        self.tableView.reloadData()
    }
    
    func onTableViewReady(source: FavoritesTableViewSource?) {
        tableView.dataSource = source
        tableView.delegate = source
        tableView.reloadData()
    }
}
