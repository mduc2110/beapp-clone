//
//  BannerController.swift
//  beclone
//
//  Created by duc.vu1 on 17/04/2022.
//

import Foundation
import UIKit

class BannerController : CollectionCellController {
    private var cell : SliderCell?
    
    func cell(for collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: SliderCell.sliderCellIdentifier, for: indexPath)
        cell = myCell as? SliderCell
        return myCell
    }
    func display() {
        cell?.layer.cornerRadius = 5
    }
    func endDisplay() {
        cell = nil
    }
}
