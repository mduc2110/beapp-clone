//
//  TripCell.swift
//  beclone
//
//  Created by duc.vu1 on 07/04/2022.
//

import Foundation
import UIKit
import FrameLayoutKit


class TransportCell : UICollectionViewCell, UICollectionViewDelegate {
    static let tripCellIdentifier : String = "tripCellIdentifier"
    
    let addressCellIdentifier = "addressCellIdentifier"
    
    //UI List Address Button
    private lazy var addressListCollectionView : UICollectionView = {
//        var collectionView = UICollectionView()
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.scrollDirection = .horizontal
        
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
//        layout.itemSize = CGSize(width: 60, height: 32)
        var collectionView = UICollectionView(frame: contentView.frame, collectionViewLayout: layout)
        collectionView.alwaysBounceHorizontal = true
        collectionView.register(LocationCell.self, forCellWithReuseIdentifier: addressCellIdentifier)
        collectionView.collectionViewLayout.invalidateLayout()

        return collectionView
    }()

    private lazy var addButtonView : UIView = {
        let addButtonView = UIView()
        return addButtonView
    }()
    
    private lazy var bottomLine : UIView = {
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor(red: 242/255, green: 245/255, blue: 247/255, alpha: 1)

        bottomLine.frame = CGRect(x: 0, y: 0, width: contentView.bounds.width - 12.84 - 12.63 - 24, height: 1)
        return bottomLine
    }()
    
    //UI Button
    private lazy var addButton : UIButton = {
        var button = UIButton()
        button.layer.cornerRadius = 20
        button.backgroundColor = UIColor(red: 242/255, green: 245/255, blue: 247/255, alpha: 1)
        button.setTitle("Thêm nhà", for: .normal)
        button.setTitleColor(UIColor(red: 8/255, green: 31/255, blue: 66/255, alpha: 1), for: .normal)
        return button
    }()
    
    //UI Icon image
    private lazy var fromAddressIcon : UIImageView = {
        let uiImage = UIImageView()
        
        uiImage.image = UIImage(named: "Transport")
        
        return uiImage
    }()
    
    private lazy var toAddressIcon : UIImageView = {
        let uiImage = UIImageView()
        uiImage.image = UIImage(named: "Union")
        return uiImage
    }()
    //UI Text Field
    private lazy var currentAddressTextField : UITextField = {
        let textField = UITextField()
        textField.addBorder(toSide: .Bottom, withColor: CGColor(red: 242/255, green: 245/255, blue: 247/255, alpha: 1), andThickness: 0.2)
        textField.text = "146 Nguyễn Đình Chiều, Phường Võ Thị Sáu Quận 3"
        textField.textColor = .black
        textField.font = UIFont.boldSystemFont(ofSize: 14)
        textField.setBottomBorder(color: UIColor(red: 242/255, green: 245/255, blue: 247/255, alpha: 1))
//        textField.becomeFirstResponder()
        return textField
    }()
    private lazy var toAddressTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "Nhập điểm đến"
        textField.tintColor = UIColor(red: 144/255, green: 154/255, blue: 170/255, alpha: 1)
        return textField
    }()
    
    let dummyAddress = [
        "Suggest Location",
        "Công ty",
        "Nhà",
        "Nhà người yêu 1",
        "Nhà người yêu 2",
        "Nhà người yêu 3"
    ]
    
    private let frameLayouts = VStackLayout()
    
    override init(frame : CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 6
        self.backgroundColor = .white
        
        addressListCollectionView.dataSource = self
        addressListCollectionView.delegate = self
        
        
        contentView.addSubview(fromAddressIcon)
        contentView.addSubview(currentAddressTextField)
        
        contentView.addSubview(bottomLine)
        
        contentView.addSubview(toAddressIcon)
        contentView.addSubview(toAddressTextField)
        
        contentView.addSubview(addressListCollectionView)
        
        frameLayouts.with {
            $0 + HStackLayout {
                $0 + fromAddressIcon
                $0 + 12.63
                $0 + currentAddressTextField
                $0.padding(top: 13, left: 5, bottom: 13, right: 4)
            }
            ($0 + bottomLine).alignment = (.top, .right)
            ($0 + bottomLine).padding(top: 0, left: 24 + 12, bottom: 0, right: 0)
            $0 + HStackLayout {
                $0 + toAddressIcon
                $0 + 16.45
                $0 + toAddressTextField
                $0.padding(top: 12, left: 9, bottom: 12, right: 4)
            }
            $0 + addressListCollectionView
        }
        frameLayouts.padding(top: 12, left: 12, bottom: 12, right: 12)
        
        contentView.addSubview(frameLayouts)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let size = frameLayouts.sizeThatFits(contentView.bounds.size)
        frameLayouts.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension TransportCell : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dummyAddress.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: addressCellIdentifier, for: indexPath) as! LocationCell
        cell.label.text = dummyAddress[indexPath.row]
        return cell
    }
}

extension TransportCell : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cell = LocationCell()

        let viewSize = collectionView.bounds.size

        let autoFitSize = cell.sizeThatFits(viewSize)
        return CGSize(width: autoFitSize.width, height: 32)
    }
//
    
}

