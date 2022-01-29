//
//  SplashViewModel.swift
//  marvel
//
//  Created by Kagan Girgin on 1/28/22.
//

import RxSwift

final class SplashViewModel: BaseViewModel {
    private let services: RestClient
    private let disposeBag = DisposeBag()
    var coordinator: SplashCoordinator?
    
    let isReady = BehaviorSubject<Bool>(value: false)
    let isError = BehaviorSubject<BaseModelError?>(value: nil)
    
    init(services: RestClient) {
        self.services = services
    }
    
    func getRadios() {
        services.getCharacters(offset: appDelegate.resultCharacters.value?.data?.results?.count ?? 0, successCompletion: { [weak self] success in
            self?.appDelegate.resultCharacters.accept(success)
        }, errorCompletion: { [weak self] error in
            self?.isError.onNext(error)
        })
    }
    
    func setBindings() {
        appDelegate.resultCharacters.asObservable()
            .map { $0 != nil }.bind(to: isReady)
            .disposed(by: disposeBag)
    }
}
