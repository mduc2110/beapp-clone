//
//  ViewController.swift
//  beclone
//
//  Created by duc.vu1 on 04/04/2022.
//

import UIKit

class CellController {
    
}


class CategoryHeaderView: UICollectionReusableView {
    
    let label = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.layer.cornerRadius = 10
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
//        label.text = "Section Title"
        
        addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ViewController: UIViewController {
    
    private let cellIdentifier : String = String(describing: UICollectionViewCell.self)
    
    private let secondIdentifier : String = "secondIdentifier"
    
    let headerId = "headerId"
    let suppId = "suppId"
    
    var sessionsData : [SessionModel] = []
    
    lazy var homeScreenCollectionView : UICollectionView = {
//        let flowLayout = UICollectionViewFlowLayout()
//        flowLayout.itemSize = CGSize(width: 80, height: 100)
//        let layout = UICollectionView(frame: view.frame, collectionViewLayout: flowLayout)
        
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 60, height: 60)
        var homeScreenCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        
        
        
        
        homeScreenCollectionView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        
        homeScreenCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        homeScreenCollectionView.register(NativeBannerCell.self, forCellWithReuseIdentifier: NativeBannerCell.nativeBannerIdentifier)
        homeScreenCollectionView.register(TripCell.self, forCellWithReuseIdentifier: TripCell.tripCellIdentifier)
        homeScreenCollectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.categoryCellIdentifier)
        
//        homeScreenCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        
//        homeScreenCollectionView.register(CategoryCell.self, forSupplementaryViewOfKind: suppId, withReuseIdentifier: secondIdentifier)
    
        homeScreenCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        homeScreenCollectionView.collectionViewLayout = createCompositionalLayout()
        homeScreenCollectionView.collectionViewLayout.register(CategoryHeaderView.self, forDecorationViewOfKind: "background")
        homeScreenCollectionView.dataSource = self
        homeScreenCollectionView.delegate = self
        
//        homeScreenCollectionView.reloadData()
        return homeScreenCollectionView
    }()//closure
    
    
    var homeScreenManager = HomeScreenManager()
    
    
    
    var cellLayout = UICollectionViewLayout()

    
    var myCollectionView:UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeScreenManager.delegate = self

        homeScreenManager.getHomeData()
//
        initHomeScreenView()

        
        configCollectionAutolayout()
        
        
        
        
//        let view = UIView()
//
//        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//        layout.sectionInset = UIEdgeInsets(top: 200, left: 10, bottom: 10, right: 10)
//        layout.itemSize = CGSize(width: 60, height: 60)
//
//        myCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
//
//        myCollectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
//        myCollectionView?.backgroundColor = nil
//
//        myCollectionView?.dataSource = self
//        myCollectionView?.delegate = self
//        myCollectionView?.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(myCollectionView ?? UICollectionView())
        
//        self.view = view
    }

    func initHomeScreenView() {
        self.view.addSubview(homeScreenCollectionView)
    }
    func configCollectionAutolayout() {
        homeScreenCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        let topConstraint = NSLayoutConstraint(item: homeScreenCollectionView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 80)
        let leadingConstraint = NSLayoutConstraint(item: homeScreenCollectionView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: homeScreenCollectionView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0)
        let trailingConstraint = NSLayoutConstraint(item: homeScreenCollectionView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0)
        NSLayoutConstraint.activate([topConstraint, leadingConstraint, bottomConstraint, trailingConstraint])
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        homeScreenCollectionView.frame = view.bounds
//        homeScreenCollectionView.reloadData()
    }
    
    
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {

        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in

         switch sectionNumber {

         case 0: return self.bannerLayoutSection()
         case 1: return self.tripLayoutSection()
         case 2: return self.categoryLayoutSection()
         default: return self.bannerLayoutSection()
         }
       }
    }
    
    private func bannerLayoutSection() -> NSCollectionLayoutSection {

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
    
    private func tripLayoutSection() -> NSCollectionLayoutSection {
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
    
    
    private func categoryLayoutSection() -> NSCollectionLayoutSection {
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
    
    private func horizontalLayoutSection() -> NSCollectionLayoutSection {

        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25), heightDimension: .absolute(100))

        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 16, leading: 16, bottom: 16, trailing: 16)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(500))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        let sectionStyling = NSCollectionLayoutDecorationItem.background(elementKind: "background")
        
        section.decorationItems = [sectionStyling]
        
//        section.orthogonalScrollingBehavior = .groupPaging

        return section
    }

    private func thirdLayoutSection() -> NSCollectionLayoutSection {
        
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

extension ViewController : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
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
            default:
                return 1
        }
//        return 20
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
//        cell.largeContentTitle = "\(indexPath.row)"
//        cell.backgroundView = UIView(frame: CGRect(x: 20, y: 20, width: 20, height: 20))
//        cell.backgroundColor = .gray
//        cell.backgroundColor = .gray
        
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
            let cate : [DataSessionModel]? = sessionsData[3].data
            if let c = cate {
                cell.configure(category: c[indexPath.row])

            } else {
                print("Error")
            }
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
//            cell.backgroundColor = .lightGray
            cell.layer.cornerRadius = 5
            return cell
        }
//        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: secondIdentifier, for: indexPath)
        return header
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
//        reutn
////        UICollectionReu
//    }
}

extension ViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       print("User tapped on item \(indexPath.row)")
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let screenWidth = UIScreen.main.bounds.width - 10
//        return CGSize(width: 200, height: screenWidth)
//    }
}


extension ViewController : HomeScreenManagerDelegate {
    func didGetBackgroundForHomeScreen(urlBackground: String) {
        
        DispatchQueue.main.async { [weak self] in
            
//            self?.view.backgroundColor = .green
//            self?.view.largeContentImage = UIImage(data: urlBackground)
            
//            let imageData : NSData = NSData(contentsOf: URL(string: urlBackground)!)
            
            let imageUrlString = urlBackground
            let imageUrl:URL = URL(string: imageUrlString)!
            
            let imageData:NSData = NSData(contentsOf: imageUrl)!
            
            self?.view.backgroundColor = UIColor(patternImage: UIImage(data: imageData as Data)!)
//            self?.view.backgroundColor = UIView.loadWithUrl(url)
        }
        
    }
    
    func didGetSessionsList(sessionsData: [SessionModel]) {
        self.sessionsData = sessionsData
        DispatchQueue.main.async {
            self.homeScreenCollectionView.reloadData()
        }
    }
}

//extension UIView {
//    func loadWithUrl(_ url : String) -> UIColor {
//
//        let imageUrl:URL = URL(string: url)!
//
//        let imageData:NSData = NSData(contentsOf: imageUrl)!
//
//        return UIColor(patternImage: UIImage(data: imageData as Data)!)
//    }
//}
