//
//  BannerController.swift
//  beclone
//
//  Created by duc.vu1 on 17/04/2022.
//

import Foundation
import UIKit

class BannerController : CollectionCellController {
    private var cell : BannerCell?
    
    var timer : Timer?
    
    var currentCellIndex = 0
    
    var imageBannerList : [String]
    
    init(imageList : [String]) {
        self.imageBannerList = imageList
    }
    
    func cell(for collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCell.bannerCellIdentifier, for: indexPath)
        cell = myCell as? BannerCell
        return myCell
    }
    func display() {
        cell?.initData(data: imageBannerList)
    }
    func endDisplay() {
        cell = nil
    }
}
