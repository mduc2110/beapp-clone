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
//        layout.itemSize = CGSize(width: 60, height: 60)
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
        return homeScreenCollectionView
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
        
//        uiButton.setTitle("100.000", for: .normal)
        
        let viewSize = view.bounds.size
        let buttonSize = uiButton.sizeThatFits(viewSize)
        uiButton.contentHorizontalAlignment = .center
        uiButton.frame = CGRect(x: 0, y: 0, width: buttonSize.width + 30, height: buttonSize.height)
        
        uiButton.layer.cornerRadius = buttonSize.height / 2
//        uiButton.titleLabel?.font = UIFont.systemFont(ofSize: 24)
//        uiButton.setTitle("Ascending Order", for: .normal)
//        uiButton.setImage(UIImage(systemName: "Icon-Color-bePoint"), for: .normal)
        return uiButton
    }()
    
    lazy var bePointAmount : UILabel = {
        let uiLabel = UILabel()
        uiLabel.translatesAutoresizingMaskIntoConstraints = false
        uiLabel.text = "100.000"
        uiLabel.font = UIFont.boldSystemFont(ofSize: 14)
        uiLabel.textColor = .white
        
        let labelAmountSize = uiLabel.sizeThatFits(view.bounds.size)
        print(labelAmountSize)
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
    
    lazy var ui : UIView = {
        let ui = UIView()
        ui.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        ui.translatesAutoresizingMaskIntoConstraints = false
//        ui.backgroundColor = .orange
        ui.largeContentTitle = "OKKK"
        return ui
    }()
    
    lazy var uiTopScreenInner : UIView = {
        let inner = UIView()
        inner.translatesAutoresizingMaskIntoConstraints = false
//        inner.backgroundColor = .orange
        return inner
    }()
    
    var homeScreenManager = HomeScreenManager()
    
    
    
    var cellLayout = UICollectionViewLayout()

    
    var myCollectionView:UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeScreenManager.delegate = self

        homeScreenManager.getHomeData()
        
        initHomeScreenView()

        
        configCollectionAutolayout()
        

    }

    func initHomeScreenView() {
        self.view.addSubview(homeScreenCollectionView)
        
        initTopScreen()
    }
    
    func initTopScreen() {
        bePointButton.addSubview(bePointAmount)
        bePointButton.addSubview(bePointIcon)
        
        uiTopScreenInner.addSubview(bePointButton)
        uiTopScreenInner.addSubview(welcomeLabel)
//        topScreenView.addSubview(bePointIcon)
        
        topScreenView.addSubview(uiTopScreenInner)
        
        topScreenView.addSubview(bePointButton)
        
        view.addSubview(topScreenView)
        
//        topScreenView.addSubview(ui)
        
        
        configTopScreenConstraints()
        
        NSLayoutConstraint.activate([
            uiTopScreenInner.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            uiTopScreenInner.bottomAnchor.constraint(equalTo: topScreenView.bottomAnchor),
            uiTopScreenInner.leftAnchor.constraint(equalTo: topScreenView.leftAnchor),
            uiTopScreenInner.rightAnchor.constraint(equalTo: topScreenView.rightAnchor),
//            uiTopScreenInner.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        
        
    }
    
    func configTopScreenConstraints() {
        let constraints = [
            topScreenView.topAnchor.constraint(equalTo: view.topAnchor),
            topScreenView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            topScreenView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            topScreenView.bottomAnchor.constraint(equalTo: uiTopScreenInner.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        
        let welcomeLabelConstraints = [
            welcomeLabel.centerYAnchor.constraint(equalTo: uiTopScreenInner.centerYAnchor),
            welcomeLabel.leftAnchor.constraint(equalTo: uiTopScreenInner.leftAnchor, constant: 16),
            
//            welcomeLabel.bottomAnchor.constraint(equalTo: topScreenView.bottomAnchor, constant: -12),
        ]
        NSLayoutConstraint.activate(welcomeLabelConstraints)
        
        
        let innerButtonPadding = (bePointButton.bounds.height - 16.67) / 2
        
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
        
        
        
//        NSLayoutConstraint.activate([
//            ui.topAnchor.constraint(equalTo: topScreenView.topAnchor),
//            ui.leftAnchor.constraint(equalTo: topScreenView.leftAnchor, con),
//            ui.heightAnchor.constraint(equalToConstant: 48),
//            ui.widthAnchor.constraint(equalToConstant: 48)
//        ])
    }
    
    func configCollectionAutolayout() {
        homeScreenCollectionView.translatesAutoresizingMaskIntoConstraints = false
      
        homeScreenCollectionView.topAnchor.constraint(equalTo: topScreenView.bottomAnchor).isActive = true
        homeScreenCollectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        homeScreenCollectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        homeScreenCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
//        homeScreenCollectionView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height).isActive = true
//        homeScreenCollectionView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
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
            cell.layer.cornerRadius = 5
            return cell
        }
//        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: secondIdentifier, for: indexPath)
        return header
    }

}

extension ViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       print("User tapped on item \(indexPath.row)")
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView == homeScreenCollectionView {
            let contentOffset = scrollView.contentOffset.y
            if(contentOffset >= view.safeAreaInsets.top + uiTopScreenInner.bounds.height) {
                UIView.animate(withDuration: 0.3) {
                    self.topScreenView.backgroundColor = .white
                    self.welcomeLabel.setBeDarkColor()
                    self.bePointAmount.setBeDarkColor()
                }
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.topScreenView.backgroundColor = .clear
                    self.welcomeLabel.setBeLightColor()
                    self.bePointAmount.setBeLightColor()
                }
            }
        }
    }
}


extension ViewController : HomeScreenManagerDelegate {
    func didGetBackgroundForHomeScreen(urlBackground: String) {
        
        DispatchQueue.main.async { [weak self] in
            let imageUrlString = urlBackground
            let imageUrl:URL = URL(string: imageUrlString)!
            
            let imageData:NSData = NSData(contentsOf: imageUrl)!
            
            self?.view.backgroundColor = UIColor(patternImage: UIImage(data: imageData as Data)!)
        }
        
    }
    
    func didGetSessionsList(sessionsData: [SessionModel]) {
        self.sessionsData = sessionsData
        DispatchQueue.main.async {
            self.homeScreenCollectionView.reloadData()
        }
    }
}
