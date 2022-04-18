//
//  NativeBannerCellController.swift
//  beclone
//
//  Created by duc.vu1 on 15/04/2022.
//

import UIKit

class NativeBannerCellController: CollectionCellController {
    let imageUrl: String
    private var cell: NativeBannerCell?
    
    init(imageUrl: String) {
        self.imageUrl = imageUrl
    }
    
    func display() {
        cell?.setImage(imageUrl: imageUrl)
    }
    
    func cell(for collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: NativeBannerCell.nativeBannerIdentifier, for: indexPath)
        cell = myCell as? NativeBannerCell
        return myCell
    }
    
    func endDisplay() {
        cell = nil
    }
}
