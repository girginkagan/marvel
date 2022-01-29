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
    func getNextPage()
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
    let isError = BehaviorSubject<BaseModelError?>(value: nil)
    var page = 1
    
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
                self?.tableViewSource.value?.isLoadingList = false
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
    
    func getNextPage() {
        services.getCharacters(offset: appDelegate.resultCharacters.value?.data?.results?.count ?? 0, successCompletion: { [weak self] success in
            if (success.data?.results?.count ?? 0) < 30 {
                self?.tableViewSource.value?.noMorePage = true
            }
            
            if (success.data?.results?.count ?? 0) != 0 {
                self?.page += 1
            }
            var newData = self?.appDelegate.resultCharacters.value
            self?.tableViewSource.value?.data.append(contentsOf: success.data?.results ?? [])
            newData?.data?.results?.append(contentsOf: success.data?.results ?? [])
            
            self?.appDelegate.resultCharacters.accept(newData)
        }, errorCompletion: { [weak self] error in
            self?.isError.onNext(error)
        })
    }
}
