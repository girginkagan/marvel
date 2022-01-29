//
//  HomeViewController.swift
//  marvel
//
//  Created by Kagan Girgin on 1/28/22.
//

import UIKit

class HomeViewController: UIViewController, Storyboarded {
    static var storyboard = AppStoryboard.Home
    var viewModel: HomeViewModel?

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setBindings()
    }
    
    private func setUI() {
        let barButtonFavorite = UIBarButtonItem(image: UIImage(named: "ic_favorite_filled"), style: .plain, target: self, action: #selector(didTapBarButtonFavorite))
        let barButtonLogo = UIBarButtonItem(image: UIImage(named: "ic_logo_titleview"), style: .plain, target: self, action: #selector(didTapBarButtonLogo))
        navigationItem.rightBarButtonItem = barButtonFavorite
        navigationItem.leftBarButtonItem = barButtonLogo
        
        tableView.register(UINib(nibName: "HomeCharacterTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeCharacterTableViewCell")
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 20, right: 0)
    }
    
    private func setBindings() {
        guard let viewModel = viewModel else { return }
        
        viewModel.setBindings(tableViewInputDelegate: self)
    }
    
    @objc func didTapBarButtonFavorite() {
        print("tapped")
    }
    
    @objc func didTapBarButtonLogo() {
        if tableView.numberOfRows(inSection: 0) > 0 {
            tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        }
    }
}

extension HomeViewController: HomeTableViewInput {
    func onReloadTableView() {
        tableView.reloadData()
    }
    
    func onTableViewReady(source: HomeTableViewSource?) {
        tableView.dataSource = source
        tableView.delegate = source
        tableView.reloadData()
    }
}