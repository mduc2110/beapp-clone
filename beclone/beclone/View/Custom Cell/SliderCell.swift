//
//  SliderCell.swift
//  beclone
//
//  Created by duc.vu1 on 14/04/2022.
//

import Foundation
import UIKit

class SliderCell : UICollectionViewCell {
    lazy var imgBanner : UIImageView = {
        let img = UIImageView()
        img.load(urlString: "https://drivadz.vn/media/uploads/cms/47180256_309663653211557_5252010709629272064_n.png")
        img.contentMode = .scaleAspectFill
        img.layer.cornerRadius = 6
        img.layer.masksToBounds = true
        
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imgBanner)
        
        NSLayoutConstraint.activate([
            imgBanner.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imgBanner.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imgBanner.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            imgBanner.heightAnchor.constraint(equalTo: contentView.heightAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
