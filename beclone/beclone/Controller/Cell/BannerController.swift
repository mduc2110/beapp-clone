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
    private var indexPath : IndexPath?
    private var collectionView : UICollectionView?
    
    var timer : Timer?
    
    var currentCellIndex = 0
    
    func cell(for collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: SliderCell.sliderCellIdentifier, for: indexPath)
        cell = myCell as? SliderCell
        self.indexPath = indexPath
        self.collectionView = collectionView
        return myCell
    }
    func display() {
        print(currentCellIndex)
//        let pageControl = UIPageControl()
//        pageControl.numberOfPages = 5
//        pageControl.translatesAutoresizingMaskIntoConstraints = false
//        cell?.layer.cornerRadius = 5
//        cell?.backgroundColor = .white
//        cell?.contentView.addSubview(pageControl)
        
//        NSLayoutConstraint.activate([
//            pageControl.centerXAnchor.constraint(equalTo: cell?.contentView.topAnchor),
//            pageControl.centerYAnchor.constraint(equalTo: (cell?.contentView.centerYAnchor)!)
//        ])
//        if !(timer?.isValid ?? false) {
//            timer?.invalidate()
//            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(slideToNext), userInfo: nil, repeats: false)
//        }
        
    }
    
    @objc func slideToNext() {

        let section = indexPath?.section

        currentCellIndex = (currentCellIndex + 1) % 3
//
//        print(currentCellIndex)

        collectionView?.scrollToItem(at: IndexPath(item: currentCellIndex, section: section!), at: .centeredHorizontally, animated: true)
    }
    
    func endDisplay() {
        cell = nil
    }
}
