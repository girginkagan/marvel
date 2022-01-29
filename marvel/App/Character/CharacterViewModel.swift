//
//  CharacterViewModel.swift
//  marvel
//
//  Created by Kagan Girgin on 1/29/22.
//

import RxSwift
import RxCocoa

protocol ComicCollectionViewInput {
    func onCollectionViewReady(source: ComicCollectionViewSource?)
}

final class CharacterViewModel: BaseViewModel {
    private let services: RestClient
    var coordinator: CharacterCoordinator?
    let disposeBag = DisposeBag()
    var collectionViewSource = BehaviorRelay<ComicCollectionViewSource?>(value: nil)
    let isError = BehaviorRelay<BaseModelError?>(value: nil)
    var collectionViewInputDelegate: ComicCollectionViewInput?
    
    init(services: RestClient) {
        self.services = services
    }
    
    func setBindings(collectionViewInputDelegate: ComicCollectionViewInput, data: CharacterResult) {
        self.collectionViewInputDelegate = collectionViewInputDelegate
        
        collectionViewSource.subscribe { [weak self] event in
            if let source = self?.collectionViewSource.value {
                self?.collectionViewInputDelegate?.onCollectionViewReady(source: source)
            }
        }.disposed(by: disposeBag)
        
        getComics(data: data)
    }
    
    func getComics(data: CharacterResult) {
        services.getComicsByCharacter(characterId: data.id ?? 0) { [weak self] success in
            self?.collectionViewSource.accept(ComicCollectionViewSource(data: success.data?.results?.reversed() ?? []))
        } errorCompletion: { [weak self] error in
            self?.isError.accept(error)
        }
    }
}
