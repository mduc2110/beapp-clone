//
//  NativeBannerController.swift
//  beclone
//
//  Created by duc.vu1 on 06/04/2022.
//

import Foundation
import UIKit

class NativeBannerCell : UICollectionViewCell {
    static let nativeBannerId = "NativeBannerId"
    static let nativeBannerIdentifier = "nativeBannerIdentifier"
    
    let uiImage = UIImageView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        uiImage.contentMode = .scaleAspectFit
//        self.backgroundColor = .black
        
//        uiImage.layer.cornerRadius = 20
//        uiImage.layer.masksToBounds = true
//        addSubview(<#T##view: UIView##UIView#>)
    }
    
    func setImage(imageUrl : String) {
        uiImage.translatesAutoresizingMaskIntoConstraints = false
        
        
//

        
        uiImage.load(urlString: imageUrl)
        
        contentView.addSubview(uiImage)
        
        
//        NSLayoutConstraint.activate([
//
//            uiImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            uiImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            uiImage.topAnchor.constraint(equalTo: contentView.topAnchor),
//            uiImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
////            uiImage.centerXAnchor.constraint(equalTo: centerXAnchor),
////            uiImage.centerYAnchor.constraint(equalTo: centerYAnchor)
//        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        uiImage.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
