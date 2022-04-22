//
//  CategoryCell.swift
//  beclone
//
//  Created by duc.vu1 on 08/04/2022.
//

import Foundation
import UIKit
import FrameLayoutKit


class CategoryCell : UICollectionViewCell {
    static let categoryCellIdentifier = "categoryCellIdentifier"
    
    static let decorationKind = "background"
    
    private lazy var categoryName : UILabel = {
        let name = UILabel()
        name.text = "Vé xe khách"
        name.font = UIFont.systemFont(ofSize: 12)
        return name
    }()
    
    private var imagePoint : CGPoint?
    
    private var promoteCell : Int?
    
    private var labelName : String?
    
    private lazy var topLabel : UILabel = {
       let newLabel = UILabel()
        newLabel.text = "New"
        newLabel.font = UIFont.systemFont(ofSize: 8)
        newLabel.backgroundColor = UIColor(red: 241/255, green: 71/255, blue: 71/255, alpha: 1)
        newLabel.textColor = .white
        
        newLabel.textAlignment = .center
        newLabel.layer.borderWidth = 2
        newLabel.layer.masksToBounds = true
        newLabel.layer.borderColor = CGColor(red: 1, green: 1, blue: 1, alpha: 1)
        
        return newLabel
    }()
    
    private lazy var categoryImage : UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    
    let frameLayouts = VStackLayout()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = 6
//        self.backgroundColor = .white
    }
    
    func configure(category : DataSectionModel?) {
        if let ca = category {
            categoryImage.load(urlString: ca.image)
            categoryName.text = ca.title.vi

            promoteCell = ca.promoted
            
            labelName = ca.label?.vi

            initView(promoted: ca.promoted)
        }
    }
    
    private func setPromoteCellStyle() {
        self.backgroundColor = UIColor(red: 242/255, green: 245/255, blue: 247/255, alpha: 1)
        self.layer.cornerRadius = 6
        self.categoryName.font = UIFont.boldSystemFont(ofSize: 14)
    }
    
    private func initView(promoted : Int) {
        
        contentView.addSubview(categoryImage)
        contentView.addSubview(categoryName)
        contentView.addSubview(topLabel)
        
        frameLayouts.removeAll()
        
        frameLayouts.with {

            if promoted == 1 {
                $0 + HStackLayout {
                    ($0 + categoryImage).with {
                        $0.fixedSize = CGSize(width: 40, height: 40)
                        $0.alignment.horizontal = .center
                    }
                    $0.spacing(8)
                    ($0 + categoryName)
                        .with {
                            $0.alignment.horizontal = .center
                        }
                    $0.flexible()
                }
                frameLayouts.padding(top: 0, left: 12, bottom: 0, right: 12)
            }
            else {
                ($0 + categoryImage).with {
                    $0.fixedSize = CGSize(width: 40, height: 40)
                    $0.alignment.horizontal = .center
                }
                $0.spacing(8)
                ($0 + categoryName)
                    .with {
                    $0.alignment.horizontal = .center
                }
//                $0.debug = true
            }
        }
        contentView.addSubview(frameLayouts)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        frameLayouts.frame = CGRect(x: 0, y: 0, width: contentView.bounds.width, height: contentView.bounds.height)
        
        configLabelName()
        if let safePromoteValue = promoteCell,
           safePromoteValue == 1 {
            setPromoteCellStyle()
        }
    }
    
    func configLabelName() {
        guard let safeLabelName = labelName else { return }
        let parentFrame = topLabel.sizeThatFits(contentView.bounds.size)
        topLabel.frame = CGRect(x: contentView.bounds.width / 2, y: -parentFrame.height / 2, width: parentFrame.width + 12, height: parentFrame.height + 4)
        topLabel.layer.cornerRadius = topLabel.frame.height / 2
        topLabel.text = safeLabelName
        
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
