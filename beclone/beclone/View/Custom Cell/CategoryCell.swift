//
//  CategoryCell.swift
//  beclone
//
//  Created by duc.vu1 on 08/04/2022.
//

import Foundation
import UIKit


class CategoryCell : UICollectionViewCell {
    static let categoryCellIdentifier = "categoryCellIdentifier"
    
    static let decorationKind = "background"
    
    private let uiLabel = UILabel()
    
    private lazy var categoryName : UILabel = {
        let name = UILabel()
        name.text = "Vé xe khách"
        name.font = UIFont.systemFont(ofSize: 12)
        return name
    }()
    
    private lazy var topLabel : UILabel = {
       let newLabel = UILabel()
        newLabel.text = "New"
        newLabel.font = UIFont.systemFont(ofSize: 12)
        newLabel.backgroundColor = UIColor(red: 241/255, green: 71/255, blue: 71/255, alpha: 1)
        newLabel.textColor = .white
        
//        let labelSize = newLabel.sizeThatFits(contentView.bounds.size)
//        newLabel.frame = CGRect(x: 0, y: 0, width: labelSize.width + 200, height: newLabel.frame.size.height)
        
        let maxSize = CGSize(width: 300, height: newLabel.frame.size.height + 10)
        let size = newLabel.sizeThatFits(maxSize)
        newLabel.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
        
        newLabel.textAlignment = .center
        newLabel.layer.cornerRadius = (newLabel.frame.size.height + 3) / 2
        newLabel.layer.borderWidth = 2
        newLabel.layer.masksToBounds = true
        newLabel.layer.borderColor = CGColor(red: 1, green: 1, blue: 1, alpha: 1)
        
        
        return newLabel
    }()
    
    private lazy var categoryImage : UIImageView = {
        let imgView = UIImageView()
//        imgView.load(urlString: "https://imgcdn.be.com.vn/be-config/services/ic-home-challenges%403x.png")

//        imgView.bounds.size = CGSize(width: self.frame.size.width - 20, height: self.frame.size.width - 20)
//        imgView.layer.masksToBounds = true //overflow : hidden
//        imgView.layer.cornerRadius = (imgView.frame.size.width * 0.84) / 2
        return imgView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = 6
        self.backgroundColor = .white
        
        self.frame = CGRect(x: 0 , y: 0, width: 200, height: 200)
        self.bounds = CGRect(x: 0 , y: 0, width: 200, height: 200)
        
    }
    
    func configure(category : DataSessionModel?) {
        if let ca = category {
            categoryImage.load(urlString: ca.image)
            categoryName.text = ca.title.vi
            
            if ca.promoted == 1 {
                setPromoteCellStyle()
            }
            
            var newLabel = 0
            if let safeLabel = ca.label {
                newLabel = 1
                self.topLabel.text = safeLabel.vi
            }
            
            initView(promoted: ca.promoted, isNew: newLabel)
        }

    }
    
    func setPromoteCellStyle() {
        self.backgroundColor = UIColor(red: 242/255, green: 245/255, blue: 247/255, alpha: 1)
        self.layer.cornerRadius = 6
        self.categoryName.font = UIFont.boldSystemFont(ofSize: 14)
    }
    
    func initView(promoted : Int, isNew : Int) {
        contentView.addSubview(categoryImage)
        contentView.addSubview(categoryName)
        
        categoryName.translatesAutoresizingMaskIntoConstraints = false
        categoryImage.translatesAutoresizingMaskIntoConstraints = false

        configImageConstraints(isPromoted: promoted)
        configNameConstraints(isPromoted: promoted)

        
        if isNew == 1 {
            contentView.addSubview(topLabel)
            topLabel.translatesAutoresizingMaskIntoConstraints = false
            configNewLabelConstraints()
        }
    }
    
    func configImageConstraints(isPromoted : Int) {
        NSLayoutConstraint.deactivate(categoryImage.constraints)
        let constraints = [
            categoryImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            categoryImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            categoryImage.heightAnchor.constraint(equalToConstant: 40),
            categoryImage.widthAnchor.constraint(equalToConstant: 40),
        ]
        let promoteConstraints = [
            categoryImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12),
            categoryImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            categoryImage.heightAnchor.constraint(equalToConstant: 40),
            categoryImage.widthAnchor.constraint(equalToConstant: 40),
        ]
        if isPromoted == 1 {
            NSLayoutConstraint.activate(promoteConstraints)
        } else {
            NSLayoutConstraint.activate(constraints)
        }
    }
    
    func configNameConstraints(isPromoted : Int) {
        NSLayoutConstraint.deactivate(categoryName.constraints)
        
        let nameConstraints = [
            categoryName.topAnchor.constraint(equalTo: categoryImage.bottomAnchor, constant: 11),
            categoryName.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ]
    
        let promoteNameConstraints = [
            categoryName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            categoryName.leftAnchor.constraint(equalTo: categoryImage.rightAnchor, constant: 12)
        ]
        if isPromoted == 1 {
            NSLayoutConstraint.activate(promoteNameConstraints)
        } else {
            NSLayoutConstraint.activate(nameConstraints)
        }
    }

    func configNewLabelConstraints() {
        let constraints = [
                topLabel.topAnchor.constraint(equalTo: categoryImage.topAnchor, constant: -7),
                topLabel.centerXAnchor.constraint(equalTo: categoryImage.centerXAnchor, constant: (topLabel.frame.width + 20) / 2),
                topLabel.widthAnchor.constraint(equalToConstant: topLabel.frame.width + 20),
                topLabel.heightAnchor.constraint(equalToConstant: topLabel.frame.height + 2)
            ]
        topLabel.clearConstraints(constraints: constraints)
        NSLayoutConstraint.activate(constraints)
    }
    
    
    
    func setLabel(txt : String) {
        self.uiLabel.text = txt
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIView {
    func clearConstraints(constraints : [NSLayoutConstraint]) {
        for constraint in constraints {
            self.removeConstraint(constraint)
        }
    }
}
