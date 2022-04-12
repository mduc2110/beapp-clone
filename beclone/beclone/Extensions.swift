//
//  Extensions.swift
//  beclone
//
//  Created by duc.vu1 on 04/04/2022.
//

import Foundation


import UIKit

extension UIImageView {

    func load(urlString : String)  {
        guard let url = URL(string : urlString) else {
            return
        }
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

extension UIView {

    enum ViewSide {
        case Left, Right, Top, Bottom
    }

    func addBorder(toSide side: ViewSide, withColor color: CGColor, andThickness thickness: CGFloat) {

        let border = CALayer()
        border.backgroundColor = color

        switch side {
        case .Left: border.frame = CGRect(x: frame.minX, y: frame.minY, width: thickness, height: frame.height); break
        case .Right: border.frame = CGRect(x: frame.maxX, y: frame.minY, width: thickness, height: frame.height); break
        case .Top: border.frame = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: thickness); break
        case .Bottom: border.frame = CGRect(x: frame.minX, y: frame.maxY, width: frame.width, height: thickness); break
        }

        layer.addSublayer(border)
    }
    
    func setBottomBorder(color : UIColor) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.opacity = 1.0
        self.layer.cornerRadius = 0
    }
    
}

protocol UITextColor {
    func setBeDarkColor()
    func setBeLightColor()
}

extension UILabel : UITextColor {
    func setBeDarkColor() {
        self.textColor = UIColor(red: 8/255, green: 31/255, blue: 66/255, alpha: 1)
    }
    
    func setBeLightColor() {
        self.textColor = .white
    }
    
    
}
