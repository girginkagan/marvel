//
//  CharacterViewController.swift
//  marvel
//
//  Created by Kagan Girgin on 1/29/22.
//

import UIKit
import RxSwift

class CharacterViewController: UIViewController, Storyboarded {
    static var storyboard = AppStoryboard.Character
    var viewModel: CharacterViewModel?

    @IBOutlet weak var cvComics: UICollectionView!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var ivItem: UIImageView!
    
    var data: CharacterResult?
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setBindings()
    }
    
    private func setUI() {
        if let path = data?.thumbnail?.path, let ext = data?.thumbnail?.thumbnailExtension {
            ivItem.kf.setImage(with: URL(string: path.replacingOccurrences(of: "http", with: "https") + "." + ext))
        } else {
            ivItem.image = nil
        }
        
        lblTitle.text = data?.name
        lblDesc.text = data?.resultDescription
        
        cvComics.register(UINib(nibName: "ComicCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ComicCollectionViewCell")
        cvComics.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
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
        
        viewModel.isFavorite
            .bind { [weak self] data in
                if let isFavorite = data {
                    guard let self = self else { return }
                    let barButtonFavorite = UIBarButtonItem(image: UIImage(named: isFavorite ? "ic_favorite_filled" : "ic_favorite"), style: .plain, target: self, action: #selector(self.didTapBarButtonFavorite))
                    self.navigationItem.rightBarButtonItem = barButtonFavorite
                }
            }
            .disposed(by: disposeBag)
        
        guard let data = data else {
            return
        }

        viewModel.setBindings(collectionViewInputDelegate: self, data: data)
    }
    
    @objc private func didTapBarButtonFavorite() {
        viewModel?.favoriteCharacter(data: data)
    }
}

extension CharacterViewController: ComicCollectionViewInput {
    func onCollectionViewReady(source: ComicCollectionViewSource?) {
        cvComics.dataSource = source
        cvComics.delegate = source
        cvComics.reloadData()
    }
}
