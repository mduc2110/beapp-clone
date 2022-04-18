//
//  File.swift
//  beclone
//
//  Created by duc.vu1 on 15/04/2022.
//

import UIKit

protocol CollectionCellController {
    func cell(for collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell
    func display()
    func endDisplay()
}
