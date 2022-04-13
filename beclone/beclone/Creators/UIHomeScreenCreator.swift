//
//  UIHomeScreenCreator.swift
//  beclone
//
//  Created by duc.vu1 on 13/04/2022.
//

import Foundation
import UIKit

class UIHomeScreenCreator {
    let parentController : ViewController?
    let parentFrame : CGRect
    
    init(parentController : ViewController, parentFrame : CGRect) {
        self.parentFrame = parentFrame
        self.parentController = parentController
    }
    
    let collectionViewCreator = HomeScreenCollectionViewCreator()
    
    lazy var homeScreenCollectionView : UICollectionView = {
//        let flowLayout = UICollectionViewFlowLayout()
//        flowLayout.itemSize = CGSize(width: 80, height: 100)
//        let layout = UICollectionView(frame: view.frame, collectionViewLayout: flowLayout)
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        
        var collectionView = UICollectionView(frame: parentFrame, collectionViewLayout: layout)
        
        collectionView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)

        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: K.initialCellIdentifier)
        collectionView.register(NativeBannerCell.self, forCellWithReuseIdentifier: NativeBannerCell.nativeBannerIdentifier)
        collectionView.register(TripCell.self, forCellWithReuseIdentifier: TripCell.tripCellIdentifier)
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.categoryCellIdentifier)
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "hang")
    
        collectionView.collectionViewLayout = collectionViewCreator.createCompositionalLayout()// need to create compositional first
        
        collectionView.collectionViewLayout.register(CategoryCell.self, forDecorationViewOfKind: CategoryCell.decorationKind)//second
        return collectionView
    }()//closure
    
    lazy var topScreenView : UIView = {
        let uiView = UIView()
        uiView.translatesAutoresizingMaskIntoConstraints = false
//        uiView.backgroundColor = .orange
        return uiView
    }()
    lazy var welcomeLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Chào Vũ Mạnh Đức!"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    lazy var bePointButton : UIButton = {
       let uiButton = UIButton()
        uiButton.translatesAutoresizingMaskIntoConstraints = false
        uiButton.backgroundColor = UIColor(red: 94/255, green: 109/255, blue: 132/255, alpha: 0.5)
        
        
        let viewSize = parentController?.view.bounds.size
        let buttonSize = uiButton.sizeThatFits(viewSize!)
        uiButton.contentHorizontalAlignment = .center
        uiButton.frame = CGRect(x: 0, y: 0, width: buttonSize.width + 30, height: buttonSize.height)
        
        uiButton.layer.cornerRadius = buttonSize.height / 2
        return uiButton
    }()
    
    lazy var bePointAmount : UILabel = {
        let uiLabel = UILabel()
        uiLabel.translatesAutoresizingMaskIntoConstraints = false
        uiLabel.text = "100.000"
        uiLabel.font = UIFont.boldSystemFont(ofSize: 14)
        uiLabel.textColor = .white
        
        let parentSize = parentController?.view.bounds.size
        
        let labelAmountSize = uiLabel.sizeThatFits(parentSize!)
        
        uiLabel.frame.size = CGSize(width: labelAmountSize.width, height: labelAmountSize.height)
        return uiLabel
    }()
    lazy var bePointIcon : UIImageView = {
        let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.frame.size = CGSize(width: 16.67, height: 16.67)
        icon.image = UIImage(named: "Icon-Color-bePoint")
        return icon
    }()

    
    lazy var uiTopScreenInner : UIView = {
        let inner = UIView()
        inner.translatesAutoresizingMaskIntoConstraints = false
//        inner.backgroundColor = .green
        return inner
    }()
    
    lazy var uiRootView : UIView = {
        let rootView = UIView()
        rootView.translatesAutoresizingMaskIntoConstraints = false
//        rootView.backgroundColor = .orange
        return rootView
    }()
    
    
    func getView() -> UIView {
        
        initTopScreen()
        
        initCollectionHomeScreen()
        
        
        return uiRootView
    }
    
    func initTopScreen() {
        //add right Bepoint UI to button
        bePointButton.addSubview(bePointAmount)
        bePointButton.addSubview(bePointIcon)
        
        //add button to UI inner
        uiTopScreenInner.addSubview(bePointButton)
        
        //add welcome label to UI inner
        uiTopScreenInner.addSubview(welcomeLabel)
        
        //add inner to top screen UI
        topScreenView.addSubview(uiTopScreenInner)
        
        //add top screen to UI root view
        uiRootView.addSubview(topScreenView)
        
        
        //add top screen constraints
        addTopScreenConstraints()
    }
    
    func initCollectionHomeScreen() {
        //add collection view to root view
        uiRootView.addSubview(homeScreenCollectionView)
        //add collection view constraints
        addCollectionHomeScreenConstraints()
    }
    
    func addCollectionHomeScreenConstraints() {
        homeScreenCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        homeScreenCollectionView.topAnchor.constraint(equalTo: topScreenView.bottomAnchor).isActive = true
        homeScreenCollectionView.leftAnchor.constraint(equalTo: uiRootView.safeAreaLayoutGuide.leftAnchor).isActive = true
        homeScreenCollectionView.rightAnchor.constraint(equalTo: uiRootView.safeAreaLayoutGuide.rightAnchor).isActive = true
        homeScreenCollectionView.bottomAnchor.constraint(equalTo: uiRootView.bottomAnchor).isActive = true
    }
    
    
    func addTopScreenConstraints() {
        let innerButtonPadding = (bePointButton.bounds.height - 16.67) / 2
        
        let topScreenConstraints = [
            topScreenView.topAnchor.constraint(equalTo: uiRootView.topAnchor),
            topScreenView.leftAnchor.constraint(equalTo: uiRootView.safeAreaLayoutGuide.leftAnchor),
            topScreenView.rightAnchor.constraint(equalTo: uiRootView.safeAreaLayoutGuide.rightAnchor),
            topScreenView.bottomAnchor.constraint(equalTo: uiTopScreenInner.bottomAnchor)
        ]
        NSLayoutConstraint.activate(topScreenConstraints)
        
        
        let welcomeLabelConstraints = [
            welcomeLabel.centerYAnchor.constraint(equalTo: uiTopScreenInner.centerYAnchor),
            welcomeLabel.leftAnchor.constraint(equalTo: uiTopScreenInner.leftAnchor, constant: 16),
        ]
        NSLayoutConstraint.activate(welcomeLabelConstraints)
        
        let bePointIconConstraints = [
            bePointIcon.centerYAnchor.constraint(equalTo: bePointButton.centerYAnchor),
            bePointIcon.rightAnchor.constraint(equalTo: bePointButton.rightAnchor, constant: -innerButtonPadding),
            bePointIcon.widthAnchor.constraint(equalToConstant: 16.67),
            bePointIcon.heightAnchor.constraint(equalToConstant: 16.67)
        ]
        NSLayoutConstraint.activate(bePointIconConstraints)
        
        let bePointAmountConstraints = [
            bePointAmount.centerYAnchor.constraint(equalTo: bePointButton.centerYAnchor),
            bePointAmount.rightAnchor.constraint(equalTo: bePointIcon.leftAnchor, constant: -innerButtonPadding)
        ]
        NSLayoutConstraint.activate(bePointAmountConstraints)

        let bePointButtonConstraints = [
//            bePointButton.centerYAnchor.constraint(equalTo: topScreenView.centerYAnchor, constant: 20),
            bePointButton.rightAnchor.constraint(equalTo: uiTopScreenInner.rightAnchor, constant: -16),
//            bePointButton.widthAnchor.constraint(equalToConstant: innerButtonPadding * 3 + bePointAmount.bounds.width + bePointIcon.bounds.width)
            bePointButton.leftAnchor.constraint(equalTo: bePointAmount.leftAnchor, constant: -(innerButtonPadding + 5)),
            bePointButton.topAnchor.constraint(equalTo: uiTopScreenInner.topAnchor, constant: (innerButtonPadding + 5)),
            bePointButton.bottomAnchor.constraint(equalTo: uiTopScreenInner.bottomAnchor, constant: -(innerButtonPadding + 5)),
            
//            bePointButton.bottomAnchor.constraint(equalTo: uiTopScreenInner.bottomAnchor, constant: -12)
        ]
        NSLayoutConstraint.activate(bePointButtonConstraints)

        let topScreenInnerConstraints = [
            uiTopScreenInner.topAnchor.constraint(equalTo: uiRootView.safeAreaLayoutGuide.topAnchor),
            uiTopScreenInner.bottomAnchor.constraint(equalTo: topScreenView.bottomAnchor),
            uiTopScreenInner.leftAnchor.constraint(equalTo: topScreenView.leftAnchor),
            uiTopScreenInner.rightAnchor.constraint(equalTo: topScreenView.rightAnchor),
        ]
        
        NSLayoutConstraint.activate(topScreenInnerConstraints)
    }
    
    
    func getCollectionView() -> UICollectionView {
        return homeScreenCollectionView
    }

    func getTopScreenInnerHeight() -> CGFloat {
        return uiTopScreenInner.bounds.height
    }
    
    func animateTopScreen() {
        UIView.animate(withDuration: 0.3) {
            self.topScreenView.backgroundColor = .white
            self.welcomeLabel.setBeDarkColor()
            self.bePointAmount.setBeDarkColor()
        }
    }
    func clearAnimateTopScreen() {
        UIView.animate(withDuration: 0.3) {
            self.topScreenView.backgroundColor = .clear
            self.welcomeLabel.setBeLightColor()
            self.bePointAmount.setBeLightColor()
        }
    }
}
