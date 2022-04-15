//
//  TripCell.swift
//  beclone
//
//  Created by duc.vu1 on 07/04/2022.
//

import Foundation
import UIKit



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
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        
        return collectionView
    }()
    
    //UI Parent View
    private lazy var currentAddressView : UIView = {
        let currentAddressView = UIView()
        currentAddressView.translatesAutoresizingMaskIntoConstraints = false
//        currentAddressView.layer.borderColor = CGColor(red: 1, green: 0, blue: 0, alpha: 1)
//        currentAddressView.layer.borderWidth = 1.0
        return currentAddressView
    }()
    
    private lazy var destinationAddressView : UIView = {
        let destinationAddressView = UIView()
        destinationAddressView.translatesAutoresizingMaskIntoConstraints = false
        return destinationAddressView
    }()
    private lazy var addButtonView : UIView = {
        let addButtonView = UIView()
        addButtonView.translatesAutoresizingMaskIntoConstraints = false
        return addButtonView
    }()
    
    private lazy var bottomLine : UIView = {
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor(red: 242/255, green: 245/255, blue: 247/255, alpha: 1)
        bottomLine.translatesAutoresizingMaskIntoConstraints = false
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
    private lazy var currentAddressIcon : UIImageView = {
        let uiImage = UIImageView()
        
        uiImage.image = UIImage(named: "Transport")
        
        uiImage.translatesAutoresizingMaskIntoConstraints = false
        return uiImage
    }()
    
    private lazy var destinationAddressIcon : UIImageView = {
        let uiImage = UIImageView()
        uiImage.image = UIImage(named: "Union")
        uiImage.translatesAutoresizingMaskIntoConstraints = false
        return uiImage
    }()
    //UI Text Field
    private lazy var currentAddressTextField : UITextField = {
        let currentAddressTextField = UITextField()
        currentAddressTextField.addBorder(toSide: .Bottom, withColor: CGColor(red: 242/255, green: 245/255, blue: 247/255, alpha: 1), andThickness: 0.2)
        currentAddressTextField.text = "146 Nguyễn Đình Chiều, Phường Võ Thị Sáu Quận 3"
        currentAddressTextField.textColor = .black
        currentAddressTextField.font = UIFont.boldSystemFont(ofSize: 14)
        currentAddressTextField.setBottomBorder(color: UIColor(red: 242/255, green: 245/255, blue: 247/255, alpha: 1))
        currentAddressTextField.translatesAutoresizingMaskIntoConstraints = false
        currentAddressTextField.becomeFirstResponder()
        return currentAddressTextField
    }()
    private lazy var destinationAddressTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "Nhập điểm đến"
        textField.translatesAutoresizingMaskIntoConstraints = false
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
    
    
    override init(frame : CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 6
        self.backgroundColor = .white
        
        addressListCollectionView.dataSource = self
        addressListCollectionView.delegate = self
        
        
        
        initView()
    }
    
    func initView() {
        currentAddressView.addSubview(currentAddressIcon)
        currentAddressView.addSubview(currentAddressTextField)
        currentAddressView.addSubview(bottomLine)
        contentView.addSubview(currentAddressView)
        
        
        destinationAddressView.addSubview(destinationAddressIcon)
        destinationAddressView.addSubview(destinationAddressTextField)
        
        contentView.addSubview(destinationAddressView)
        
        
        addButtonView.addSubview(addressListCollectionView)
        contentView.addSubview(addButtonView)
        
        configUiView()
        
    }
    
    func configUiView() {
        configCurrentAddressView()
        
        configDestinationAddressView()
        
        configAddButtonField()
    }
    
    func configCurrentAddressView() {
        let currentAddressViewConstraints = [
            currentAddressView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            currentAddressView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            currentAddressView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            currentAddressView.heightAnchor.constraint(equalToConstant: 43)
//            currentAddressView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 105)
//            contentView.bottomAnchor.constraint(equalTo: currentAddressView.bottomAnchor, constant: 105),
//            contentView.rightAnchor.constraint(equalTo: currentAddressView.rightAnchor, constant: 40)
        ]
        
        NSLayoutConstraint.activate(currentAddressViewConstraints)
        
        setTextFieldConstraint(with: currentAddressTextField, to: currentAddressView)
        setIconConstraint(with: currentAddressIcon, to: currentAddressView, width: 22.37, height: 17.16)
        setBottomLineContraints()
    }
    
    func configDestinationAddressView() {
        let currentAddressViewConstraints = [
            destinationAddressView.topAnchor.constraint(equalTo: currentAddressView.bottomAnchor, constant: 8),
            destinationAddressView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            destinationAddressView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            destinationAddressView.heightAnchor.constraint(equalToConstant: 44)     //important
        ]
        NSLayoutConstraint.activate(currentAddressViewConstraints)

        setTextFieldConstraint(with: destinationAddressTextField, to: destinationAddressView)
        setIconConstraint(with: destinationAddressIcon, to: destinationAddressView, width: 14.55, height: 20)
    }
    
    func configAddButtonField() {
        let addButtonViewConstraints = [
            addButtonView.topAnchor.constraint(equalTo: destinationAddressView.bottomAnchor, constant: 8),
            addButtonView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12),
            addButtonView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12),
            addButtonView.heightAnchor.constraint(equalToConstant: 32)
//            contentView.bottomAnchor.constraint(equalTo: destinationAddressView.bottomAnchor, constant: 52)
        ]
        NSLayoutConstraint.activate(addButtonViewConstraints)
        
        setAddressCollectionViewConstraints()
    }
    
    func setTextFieldConstraint(with childElement : UIView, to parentView : UIView) {
        let textFieldConstraints = [
            childElement.rightAnchor.constraint(equalTo: parentView.rightAnchor, constant: -16),
            childElement.leftAnchor.constraint(equalTo: parentView.leftAnchor, constant: 52),
            childElement.centerYAnchor.constraint(equalTo: parentView.centerYAnchor),
            childElement.heightAnchor.constraint(equalTo: parentView.widthAnchor)
        ]
        NSLayoutConstraint.activate(textFieldConstraints)
    }
    
    func setBottomLineContraints() {
        NSLayoutConstraint.activate([
            bottomLine.widthAnchor.constraint(equalTo: currentAddressTextField.widthAnchor),
            bottomLine.heightAnchor.constraint(equalToConstant: 1),
            bottomLine.bottomAnchor.constraint(equalTo: currentAddressView.bottomAnchor),
            bottomLine.rightAnchor.constraint(equalTo: currentAddressTextField.rightAnchor)
        ])
    }
    
    func setIconConstraint(with iconElement : UIView, to parentView : UIView, width : CGFloat, height : CGFloat) {
        let currentAddressIconConstraints = [
            iconElement.leftAnchor.constraint(equalTo: parentView.leftAnchor, constant: 17),
            iconElement.centerYAnchor.constraint(equalTo: parentView.centerYAnchor),
            iconElement.widthAnchor.constraint(equalToConstant: width * 1.2),
            iconElement.heightAnchor.constraint(equalToConstant: height * 1.2)
        ]
        NSLayoutConstraint.activate(currentAddressIconConstraints)
    }
    
    func setAddressCollectionViewConstraints() {
        let addressCollectionViewConstraints = [
            addressListCollectionView.centerXAnchor.constraint(equalTo: addButtonView.centerXAnchor),
            addressListCollectionView.centerYAnchor.constraint(equalTo: addButtonView.centerYAnchor),
            addressListCollectionView.heightAnchor.constraint(equalTo: addButtonView.heightAnchor),
            addressListCollectionView.widthAnchor.constraint(equalTo: addButtonView.widthAnchor)
        ]
        NSLayoutConstraint.activate(addressCollectionViewConstraints)
    }


    override func layoutSubviews() {
        super.layoutSubviews()
//        currentAddressTextField.frame = bounds
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
//    public func collectionView(_ collectionView: UICollectionView,
//                                   layout collectionViewLayout: UICollectionViewLayout,
//                                   minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//            return 10
//        }
//
//        public func collectionView(_ collectionView: UICollectionView,
//                                   layout collectionViewLayout: UICollectionViewLayout,
//                                   minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//            return 10
//        }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
//    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cell = LocationCell()

        let viewSize = collectionView.bounds.size

        let autoFitSize = cell.sizeThatFits(viewSize)
        return CGSize(width: autoFitSize.width, height: 32)
    }
//
    
}

