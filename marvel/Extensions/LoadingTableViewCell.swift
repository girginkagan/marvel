//
//  LoadingTableViewCell.swift
//  marvel
//
//  Created by Kagan Girgin on 1/29/22.
//

import UIKit

final class LoadingTableViewCell: UITableViewCell {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func updateCell() {
        activityIndicator.startAnimating()
    }
    
}
