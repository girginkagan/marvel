//
//  ComicCollectionViewCell.swift
//  marvel
//
//  Created by Kagan Girgin on 1/29/22.
//

import UIKit

class ComicCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var ivItem: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateCell(data: ComicResult) {
        if let path = data.thumbnail?.path, let ext = data.thumbnail?.thumbnailExtension {
            ivItem.kf.setImage(with: URL(string: path.replacingOccurrences(of: "http", with: "https") + "." + ext))
        } else {
            ivItem.image = nil
        }
    }
}
