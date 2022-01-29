//
//  HomeCharacterTableViewCell.swift
//  marvel
//
//  Created by Kagan Girgin on 1/29/22.
//

import UIKit
import Kingfisher

final class HomeCharacterTableViewCell: UITableViewCell {

    @IBOutlet weak var ivItem: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func updateCell(data: CharacterResult) {
        lblName.text = data.name
        
        if let path = data.thumbnail?.path, let ext = data.thumbnail?.thumbnailExtension {
            ivItem.kf.setImage(with: URL(string: path.replacingOccurrences(of: "http", with: "https") + "." + ext))
        } else {
            ivItem.image = nil
        }
    }
    
}
