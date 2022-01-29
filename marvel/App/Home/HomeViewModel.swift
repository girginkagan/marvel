//
//  HomeViewModel.swift
//  marvel
//
//  Created by Kagan Girgin on 1/28/22.
//

import RxSwift
import RxCocoa

protocol HomeTableViewOutput {
    func onCharacterTapped(character: CharacterResult)
}

protocol HomeTableViewInput {
    func onReloadTableView()
    func onTableViewReady(source: HomeTableViewSource?)
}

final class HomeViewModel: BaseViewModel {
    private let services: RestClient
    var coordinator: HomeCoordinator?
    var tableViewSource = BehaviorRelay<HomeTableViewSource?>(value: nil)
    let disposeBag = DisposeBag()
    var tableViewInputDelegate: HomeTableViewInput?
    
    init(services: RestClient) {
        self.services = services
    }
    
    func setBindings(tableViewInputDelegate: HomeTableViewInput) {
        self.tableViewInputDelegate = tableViewInputDelegate
        
        tableViewSource.subscribe { [weak self] _ in
            if let source = self?.tableViewSource.value {
                self?.tableViewInputDelegate?.onTableViewReady(source: source)
            }
        }.disposed(by: disposeBag)
        
        appDelegate.resultCharacters.subscribe { [weak self] _ in
            if self?.tableViewSource.value != nil {
                self?.tableViewInputDelegate?.onReloadTableView()
            } else {
                self?.tableViewSource.accept(HomeTableViewSource(data: self?.appDelegate.resultCharacters.value?.data?.results ?? [], delegate: self!))
            }
        }.disposed(by: disposeBag)
    }
}

extension HomeViewModel: HomeTableViewOutput {
    func onCharacterTapped(character: CharacterResult) {
        coordinator?.presentCharacterDetail(character: character)
    }
}
