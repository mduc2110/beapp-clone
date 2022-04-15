//
//  LocationCell.swift
//  beclone
//
//  Created by duc.vu1 on 15/04/2022.
//

import Foundation
import UIKit

class LocationCell : UICollectionViewCell {
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    private func setupUI() {
        //cell styling
        self.backgroundColor = UIColor(red: 242/255, green: 245/255, blue: 247/255, alpha: 1)
        self.layer.cornerRadius = 16
        
        //label styling
        label.text = "Thêm nhà"
        label.font = UIFont(name: "AvenirNext", size: 14)
        label.textAlignment = .center
        label.textColor = UIColor(red: 8/255, green: 31/255, blue: 66/255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(label)
        
        //constraints
        label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
        label.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true

        label.heightAnchor.constraint(equalToConstant: 32).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return label.sizeThatFits(size)
    }
}
