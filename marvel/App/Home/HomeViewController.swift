//
//  HomeViewController.swift
//  marvel
//
//  Created by Kagan Girgin on 1/28/22.
//

import UIKit
import RxSwift
import Firebase

class HomeViewController: UIViewController, Storyboarded {
    static var storyboard = AppStoryboard.Home
    var viewModel: HomeViewModel?
    let disposeBag = DisposeBag()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setBindings()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        logEvent()
    }
    
    private func setUI() {
        let barButtonFavorite = UIBarButtonItem(image: UIImage(named: "ic_favorite_filled"), style: .plain, target: self, action: #selector(didTapBarButtonFavorite))
        let barButtonLogo = UIBarButtonItem(image: UIImage(named: "ic_logo_titleview"), style: .plain, target: self, action: #selector(didTapBarButtonLogo))
        navigationItem.rightBarButtonItem = barButtonFavorite
        navigationItem.leftBarButtonItem = barButtonLogo
        
        tableView.register(UINib(nibName: "HomeCharacterTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeCharacterTableViewCell")
        tableView.register(UINib(nibName: "LoadingTableViewCell", bundle: nil), forCellReuseIdentifier: "LoadingTableViewCell")
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 20, right: 0)
    }
    
    private func setBindings() {
        guard let viewModel = viewModel else { return }
        
        viewModel.isError
            .bind { [weak self] data in
                if let errorData = data {
                    guard let self = self else { return }
                    AlertUtil.showStandardAlert(parentController: self, title: "Error", message: APIErrorGenerator().generateError(error: errorData))
                }
            }
            .disposed(by: disposeBag)
        viewModel.setBindings(tableViewInputDelegate: self)
    }
    
    private func logEvent() {
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
            AnalyticsParameterItemID: String(Date().timeIntervalSince1970),
            AnalyticsParameterItemName: "Home",
            AnalyticsParameterContentType: "cont",
        ])
    }
    
    @objc private func didTapBarButtonFavorite() {
        print("tapped")
    }
    
    @objc private func didTapBarButtonLogo() {
        if tableView.numberOfRows(inSection: 0) > 0 {
            tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        }
    }
}

extension HomeViewController: HomeTableViewInput {
    func onReloadTableView() {
        self.tableView.reloadData()
    }
    
    func onTableViewReady(source: HomeTableViewSource?) {
        tableView.dataSource = source
        tableView.delegate = source
        tableView.reloadData()
    }
}
