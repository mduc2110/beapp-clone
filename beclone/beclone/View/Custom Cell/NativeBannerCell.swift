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
    
    private let uiImage = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
  
        uiImage.contentMode = .scaleAspectFit
    }
    
    func setImage(imageUrl : String) {
        uiImage.load(urlString: imageUrl)
        
        contentView.addSubview(uiImage)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        uiImage.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
