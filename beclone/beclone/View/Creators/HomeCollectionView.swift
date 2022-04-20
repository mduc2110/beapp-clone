//
//  HomeCollectionView.swift
//  beclone
//
//  Created by duc.vu1 on 19/04/2022.
//

import Foundation
import UIKit

class HomeCollectionView : UICollectionView {
    
    let collectionViewCreator = HomeScreenCollectionViewCreator()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)

        register(UICollectionViewCell.self, forCellWithReuseIdentifier: K.initialCellIdentifier)
        
        register(NativeBannerCell.self, forCellWithReuseIdentifier: NativeBannerCell.nativeBannerIdentifier)
        
        register(TransportCell.self, forCellWithReuseIdentifier: TransportCell.tripCellIdentifier)
        
        register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.categoryCellIdentifier)
        
        register(BannerCell.self, forCellWithReuseIdentifier: BannerCell.bannerCellIdentifier)
    
        translatesAutoresizingMaskIntoConstraints = false
        
        collectionViewLayout = collectionViewCreator.createCompositionalLayout()// need to create compositional first
        
        collectionViewLayout.register(CategoryCell.self, forDecorationViewOfKind: CategoryCell.decorationKind)//second
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
