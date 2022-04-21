//
//  BannerVCCellController.swift
//  beclone
//
//  Created by duc.vu1 on 20/04/2022.
//

import UIKit

class BannerVCCellController : CollectionCellController {
    var bannerCell : UICollectionViewCell?
    var urlString : String
    func cell(for collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OK", for: indexPath)
        bannerCell = cell
        return cell
    }
    init(urlString: String) {
        self.urlString = urlString
    }
    func display() {
        guard let safeBannerCell = bannerCell else { return }
        let img = UIImageView(frame: CGRect(x: 0, y: 0, width: safeBannerCell.frame.width, height: safeBannerCell.frame.height))
        img.load(urlString: urlString)
        img.contentMode = .scaleAspectFill
        safeBannerCell.addSubview(img)
    }
    
    func endDisplay() {
        bannerCell = nil
        urlString = ""
    }
}
