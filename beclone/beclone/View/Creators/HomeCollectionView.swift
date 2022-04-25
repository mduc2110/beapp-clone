//
//  HomeCollectionView.swift
//  beclone
//
//  Created by duc.vu1 on 19/04/2022.
//

import Foundation
import UIKit

class HomeCollectionView : UICollectionView {
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)

        register(UICollectionViewCell.self, forCellWithReuseIdentifier: K.initialCellIdentifier)
        
        register(NativeBannerCell.self, forCellWithReuseIdentifier: NativeBannerCell.nativeBannerIdentifier)
        
        register(TransportCell.self, forCellWithReuseIdentifier: TransportCell.tripCellIdentifier)
        
        register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.categoryCellIdentifier)
        
        register(BannerCell.self, forCellWithReuseIdentifier: BannerCell.bannerCellIdentifier)
        
        collectionViewLayout = createCompositionalLayout()// need to create compositional first
        
        collectionViewLayout.register(CategoryCell.self, forDecorationViewOfKind: CategoryCell.decorationKind)//second
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func createCompositionalLayout() -> UICollectionViewCompositionalLayout {

        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in

         switch sectionNumber {

         case 0: return self.bannerLayoutSection()
         case 1: return self.tripLayoutSection()
         case 2: return self.categoryLayoutSection()
         case 3: return self.sliderLayoutSection()
         default: return self.bannerLayoutSection()
         }
       }
    }
    
    func bannerLayoutSection() -> NSCollectionLayoutSection {

        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))

        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets.bottom = 15

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension:  .fractionalWidth(96/336))

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = .init(top: 0, leading: 12, bottom: 0, trailing: 12)

        let section = NSCollectionLayoutSection(group: group)

        section.orthogonalScrollingBehavior = .groupPaging

//        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return section
    }
    
    func tripLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets.bottom = 16
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(172))

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        group.contentInsets = .init(top: 0, leading: 16, bottom: 0, trailing: 16)

        let section = NSCollectionLayoutSection(group: group)

        section.orthogonalScrollingBehavior = .groupPaging //horizontal scrolling

        
        return section
    }
    
    
    func categoryLayoutSection() -> NSCollectionLayoutSection {
        let promoteItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(64/160 * 0.5))
        
        let promoteItem = NSCollectionLayoutItem(layoutSize: promoteItemSize)
        promoteItem.contentInsets = .init(top: 16, leading: 4, bottom: 16, trailing: 4)
        
        let promoteGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(500))
        
        let promoteGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: promoteGroupSize,
            subitem: promoteItem,
            count: 2)
        promoteGroup.contentInsets = .init(top: 0, leading: 12, bottom: 0, trailing: 12)
        
//        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(170), heightDimension: .absolute(100))

        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25), heightDimension: .absolute(100))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        item.contentInsets = .init(top: 0, leading: 16, bottom: 32, trailing: 16)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1000))
        
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        //nested group
        
        let parentGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(400)),
            subitems: [promoteGroup, group, group])
//    subitems: [promoteGroup])
//        parentGroup.contentInsets = .init(top: 0, leading: 0, bottom: 16, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: parentGroup)
        
        
        let sectionStyling = NSCollectionLayoutDecorationItem.background(elementKind: CategoryCell.decorationKind)
        
        section.decorationItems = [sectionStyling]

        return section
    }
    
    
    
    func sliderLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.56))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: 16, bottom: 16, trailing: 16)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(300))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group : group)
        
        section.orthogonalScrollingBehavior = .groupPaging
        
        
        return section
    }

}
