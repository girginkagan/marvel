//
//  CharacterViewController.swift
//  marvel
//
//  Created by Kagan Girgin on 1/29/22.
//

import UIKit
import RxSwift
import SVProgressHUD

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
        let barButtonFavorite = UIBarButtonItem(image: UIImage(named: "ic_favorite"), style: .plain, target: self, action: #selector(didTapBarButtonFavorite))
        navigationItem.rightBarButtonItem = barButtonFavorite
        
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
                    SVProgressHUD.dismiss()
                    guard let self = self else { return }
                    AlertUtil.showStandardAlert(parentController: self, title: "Error", message: APIErrorGenerator().generateError(error: errorData))
                }
            }
            .disposed(by: disposeBag)
        
        guard let data = data else {
            return
        }

        SVProgressHUD.show()
        viewModel.setBindings(collectionViewInputDelegate: self, data: data)
    }
    
    @objc func didTapBarButtonFavorite() {
        print("tapped fav btn")
    }
}

extension CharacterViewController: ComicCollectionViewInput {
    func onCollectionViewReady(source: ComicCollectionViewSource?) {
        cvComics.dataSource = source
        cvComics.delegate = source
        cvComics.reloadData()
        
        SVProgressHUD.dismiss()
    }
}
