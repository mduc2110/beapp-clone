//
//  HomeScreenCollectionViewCreator.swift
//  beclone
//
//  Created by duc.vu1 on 12/04/2022.
//

import Foundation
import UIKit

class HomeScreenCollectionViewCreator {
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
        
//        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(160/328))
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(172))

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        group.contentInsets = .init(top: 0, leading: 16, bottom: 0, trailing: 16)

        let section = NSCollectionLayoutSection(group: group)

        section.orthogonalScrollingBehavior = .groupPaging //horizontal scrolling

//        let layout = UICollectionViewCompositionalLayout(section: section)
        
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
        
//        item.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: .fixed(16), top: .fixed(16), trailing: .flexible(16), bottom: .fixed(16))
        item.contentInsets = .init(top: 0, leading: 16, bottom: 32, trailing: 16)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1000))
        
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

//        group.contentInsets.bottom = 16
        
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
//        section.contentInsets.leading = 15
        
//        section.orthogonalScrollingBehavior = .groupPaging //horizontal scrolling

        return section
    }
    
    
    
    func sliderLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.4))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 16, leading: 16, bottom: 16, trailing: 16)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(300))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group : group)
        
        section.orthogonalScrollingBehavior = .groupPaging
        
        
        return section
    }

    func thirdLayoutSection() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))

        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets.bottom = 15
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .fractionalWidth(0.35))

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = .init(top: 0, leading: 15, bottom: 0, trailing: 2)

        let section = NSCollectionLayoutSection(group: group)

        section.orthogonalScrollingBehavior = .continuous

        return section
    }
}
