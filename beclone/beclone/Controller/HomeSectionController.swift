//
//  SectionController.swift
//  beclone
//
//  Created by duc.vu1 on 12/04/2022.
//

import Foundation
import UIKit

class HomeSectionController {
    var sessionsData : [SessionModel] = []
    
    init(sessionData : [SessionModel]) {
        self.sessionsData = sessionData
    }
    func test() {
        print(sessionsData[0].name)
    }
    func setupHomeScreenSections(section : Int) -> Int {
        switch section {
            case 0:
                return 1
            case 1:
                return 1
            case 2:
                if sessionsData.count > 0 {
                    if let count = sessionsData[3].data?.count {
                        return count > 10 ? 10 : count
                    }
                    else {
                        return 0
                    }
                    
                }
                return 0
            case 3:
                return 3
            default:
                return 1
        }
    }
    
    func setupHomeScreenCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NativeBannerCell.nativeBannerIdentifier, for: indexPath) as! NativeBannerCell
            if sessionsData.count > 0 {
                if let nativeBannerImageUrl = sessionsData[0].metaData?["image"] {
                    cell.setImage(imageUrl: nativeBannerImageUrl as! String)
                }
            }
            return cell
        } else if  indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TripCell.tripCellIdentifier, for: indexPath) as! TripCell
            return cell
        }
        else if  indexPath.section == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.categoryCellIdentifier, for: indexPath) as! CategoryCell
            let services : [DataSessionModel]? = sessionsData[3].data
            if let s = services {
                cell.configure(category: s[indexPath.row])
            }
            return cell
        }
        else if indexPath.section == 3 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "hang", for: indexPath) as! SliderCell
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.initialCellIdentifier, for: indexPath)
            cell.layer.cornerRadius = 5
            return cell
        }
    }
    enum SectionName {
        case Banner, Transport, Services, Slider
    }
    func getIndexPathSection(sectionName : SectionName) -> Int{
        switch sectionName {
            case .Banner: return 0
            case .Transport: return 1
            case .Services: return 2
            case .Slider: return 3
        }
    }
}
