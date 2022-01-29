//
//  FavoritesViewModel.swift
//  marvel
//
//  Created by Kagan Girgin on 1/29/22.
//

import RxSwift
import RxCocoa
import Unrealm

protocol FavoritesTableViewOutput {
    func onCharacterTapped(character: CharacterResult)
}

protocol FavoritesTableViewInput {
    func onReloadTableView()
    func onTableViewReady(source: FavoritesTableViewSource?)
}

final class FavoritesViewModel: BaseViewModel {
    private let services: RestClient
    var coordinator: FavoritesCoordinator?
    var tableViewSource = BehaviorRelay<FavoritesTableViewSource?>(value: nil)
    var tableViewInputDelegate: FavoritesTableViewInput?
    let disposeBag = DisposeBag()
    
    init(services: RestClient) {
        self.services = services
    }
    
    func setBindings(tableViewInputDelegate: FavoritesTableViewInput) {
        self.tableViewInputDelegate = tableViewInputDelegate
        
        tableViewSource.subscribe { [weak self] _ in
            if let source = self?.tableViewSource.value {
                self?.tableViewInputDelegate?.onTableViewReady(source: source)
            }
        }.disposed(by: disposeBag)
        
        appDelegate.resultFavorites.subscribe { [weak self] _ in
            guard let val = self?.appDelegate.resultFavorites.value else { return }
            self?.tableViewSource.accept(FavoritesTableViewSource(data: val, delegate: self!))
        }.disposed(by: disposeBag)
    }
}

extension FavoritesViewModel: FavoritesTableViewOutput {
    func onCharacterTapped(character: CharacterResult) {
        coordinator?.presentCharacterDetail(character: character)
    }
}
