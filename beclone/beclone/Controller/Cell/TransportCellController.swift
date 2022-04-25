//
//  TransportCellController.swift
//  beclone
//
//  Created by duc.vu1 on 15/04/2022.
//

import Foundation
import UIKit

class TransportCellController : CollectionCellController {
    private var cell : TransportCell?
    
    func cell(for collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: TransportCell.tripCellIdentifier, for: indexPath)
        cell = myCell as? TransportCell
        return myCell
    }
    
    func display() {
    }
    
    func endDisplay() {
        cell = nil
    }
    
    
}
