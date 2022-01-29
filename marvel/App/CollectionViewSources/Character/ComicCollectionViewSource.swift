//
//  ComicCollectionViewSource.swift
//  marvel
//
//  Created by Kagan Girgin on 1/29/22.
//

import UIKit

final class ComicCollectionViewSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let data: [ComicResult]
    
    init(data: [ComicResult]) {
        self.data = data
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ComicCollectionViewCell", for: indexPath) as! ComicCollectionViewCell
        cell.updateCell(data: data[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: 210)
    }
}
