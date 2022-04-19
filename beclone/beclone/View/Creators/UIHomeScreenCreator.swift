//
//  UIHomeScreenCreator.swift
//  beclone
//
//  Created by duc.vu1 on 13/04/2022.
//

import Foundation
import UIKit

class UIHomeScreenCreator {
    weak var parentController : ViewController?
    
    let parentFrame : CGRect
    
    var topBackgroundConstraints : NSLayoutConstraint?
    
    var defaultGradientBackgroundHeight : CGFloat?
    
    let homeNavigation = HomeNavigation()
    
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
        collectionView.register(TransportCell.self, forCellWithReuseIdentifier: TransportCell.tripCellIdentifier)
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.categoryCellIdentifier)
        
        collectionView.register(SliderCell.self, forCellWithReuseIdentifier: SliderCell.sliderCellIdentifier)
    
        collectionView.collectionViewLayout = collectionViewCreator.createCompositionalLayout()// need to create compositional first
        
        collectionView.collectionViewLayout.register(CategoryCell.self, forDecorationViewOfKind: CategoryCell.decorationKind)//second
        return collectionView
    }()//closure
    
    lazy var uiRootView : UIView = {
        let rootView = UIView()
        rootView.translatesAutoresizingMaskIntoConstraints = false
//        rootView.backgroundColor = .orange
        return rootView
    }()
    
    lazy var uiGradientBackground : UIView = {
        let background = UIView()
        background.translatesAutoresizingMaskIntoConstraints = false
        background.backgroundColor = .white
        background.layer.cornerRadius =  6
//        rootView.backgroundColor = .orange
        return background
    }()
    
    func getView() -> UIView {
        initHomeNavigation()
        
        return uiRootView
    }
    
    func initTopScreen() {
        uiRootView.addSubview(uiGradientBackground)

    }
    
    func initHomeNavigation() {
        
//        homeNavigation.initHomeNavigationView(with: uiRootView)
        
//        let homeNavigationView = homeNavigation.getHomeNavigationView()
        
        
        uiRootView.addSubview(uiGradientBackground)
        
        uiRootView.addSubview(homeNavigation)
        
        NSLayoutConstraint.activate([
            homeNavigation.topAnchor.constraint(equalTo: uiRootView.topAnchor),
            homeNavigation.leftAnchor.constraint(equalTo: uiRootView.leftAnchor),
            homeNavigation.rightAnchor.constraint(equalTo: uiRootView.rightAnchor),
//            homeNavigation.heightAnchor.constraint(equalToConstant: 100)
        ])

        initCollectionHomeScreen()
    }
    
    func addBackgroundConstraints(_ top : CGFloat) {
        topBackgroundConstraints = uiGradientBackground.topAnchor.constraint(equalTo: uiRootView.topAnchor, constant: top)
        
        let constraints = [
            topBackgroundConstraints!,
            uiGradientBackground.bottomAnchor.constraint(equalTo: uiRootView.bottomAnchor),
            uiGradientBackground.leftAnchor.constraint(equalTo: uiRootView.leftAnchor),
            uiGradientBackground.rightAnchor.constraint(equalTo: uiRootView.rightAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func initCollectionHomeScreen() {
        //add collection view to root view
        uiRootView.addSubview(homeScreenCollectionView)
        //add collection view constraints

        homeScreenCollectionView.translatesAutoresizingMaskIntoConstraints = false

        homeScreenCollectionView.topAnchor.constraint(equalTo: homeNavigation.bottomAnchor).isActive = true
        homeScreenCollectionView.leftAnchor.constraint(equalTo: uiRootView.safeAreaLayoutGuide.leftAnchor).isActive = true
        homeScreenCollectionView.rightAnchor.constraint(equalTo: uiRootView.safeAreaLayoutGuide.rightAnchor).isActive = true
        homeScreenCollectionView.bottomAnchor.constraint(equalTo: uiRootView.bottomAnchor).isActive = true
    }
    
    
    func getCollectionView() -> UICollectionView {
        return homeScreenCollectionView
    }

    func getTopScreenInnerHeight() -> CGFloat {
        return homeNavigation.bounds.height
    }
    
    func animateTopScreen() {
        homeNavigation.toggleBackground(flag: true)
    }
    func clearAnimateTopScreen() {
        homeNavigation.toggleBackground(flag: false)
    }
    
    func setSectionHeight(_ sectionPosition : CGRect?) {
        
        if let safeHeight = sectionPosition?.origin.y {
            //add inset
            let safeHeightInset = safeHeight - 16
            
            defaultGradientBackgroundHeight = safeHeightInset
            
            addBackgroundConstraints(safeHeightInset)
        }
    }
    
    func updateGradientBackgroundHeight(_ contentOffset : CGFloat) {
        topBackgroundConstraints?.constant = defaultGradientBackgroundHeight! - contentOffset
    }
}

//class NavibarView: UIView {
//
//        func setBeDarkColor() {
//            self.textColor = UIColor.darkColor
//
//        }
//
//        func setBeLightColor() {
//            self.textColor = .white
//        }
//
//
//}
