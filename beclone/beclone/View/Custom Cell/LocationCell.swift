//
//  LocationCell.swift
//  beclone
//
//  Created by duc.vu1 on 15/04/2022.
//

import Foundation
import UIKit
import FrameLayoutKit

class LocationCell : UICollectionViewCell {
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    private let frameLayout = HStackLayout()
    
    private func setupUI() {
        //cell styling
        self.backgroundColor = UIColor(red: 242/255, green: 245/255, blue: 247/255, alpha: 1)
        self.layer.cornerRadius = 16
        
        //label styling
        label.text = "Thêm nhà"
        label.font = UIFont(name: "AvenirNext", size: 14)
        label.textAlignment = .center
        label.textColor = UIColor(red: 8/255, green: 31/255, blue: 66/255, alpha: 1)
        
        contentView.addSubview(label)
        frameLayout.with {
            ($0 + label)
          $0.padding(top: 6, left: 16, bottom: 6, right: 16)
        }
        contentView.addSubview(frameLayout)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        frameLayout.frame = contentView.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return frameLayout.sizeThatFits(size)
    }
}
