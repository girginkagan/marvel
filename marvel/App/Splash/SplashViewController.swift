//
//  SplashViewController.swift
//  marvel
//
//  Created by Kagan Girgin on 1/28/22.
//

import UIKit
import RxSwift

final class SplashViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var ivLogoP1CenterConstraint: NSLayoutConstraint!
    @IBOutlet weak var ivLogoP2CenterConstraint: NSLayoutConstraint!
    @IBOutlet weak var ivLogoP2: UIImageView!
    @IBOutlet weak var ivLogoP1: UIImageView!
    
    static var storyboard = AppStoryboard.Splash
    var viewModel: SplashViewModel?
    private let disposeBag = DisposeBag()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setUI()
    }
    
    private func setUI() {
        ivLogoP1CenterConstraint.constant = -72
        ivLogoP2CenterConstraint.constant = 72
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.view.layoutIfNeeded()
        }
        UIView.animate(withDuration: 0.3, delay: 0, options: []) { [weak self] in
            self?.view.layoutIfNeeded()
        } completion: { [weak self] ended in
            self?.setBindings()
        }
    }
    
    private func setBindings() {
        guard let viewModel = viewModel else { return }
        
        viewModel.setBindings()
        viewModel.getRadios()
        
        viewModel.isError
            .bind { [weak self] data in
                if let errorData = data {
                    guard let self = self else { return }
                    AlertUtil.showStandardAlert(parentController: self, title: "Error", message: APIErrorGenerator().generateError(error: errorData))
                }
            }
            .disposed(by: disposeBag)
    }

}
