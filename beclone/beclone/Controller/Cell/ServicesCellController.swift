//
//  ServicesCellController.swift
//  beclone
//
//  Created by duc.vu1 on 15/04/2022.
//

import Foundation
import UIKit

class ServicesCellController : CollectionCellController {
    let services : DataSectionModel?
    private var cell : CategoryCell?
    private var indexPath : IndexPath?
    init(services : DataSectionModel?) {
        self.services = services
    }
    
    func cell(for collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.categoryCellIdentifier, for: indexPath)
        cell = myCell as? CategoryCell
        self.indexPath = indexPath
        return myCell
    }
    func display() {
        cell?.configure(category: services)
    }
    func endDisplay() {
        cell = nil
    }
}
