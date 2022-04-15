//
//  ViewController.swift
//  beclone
//
//  Created by duc.vu1 on 04/04/2022.
//

import UIKit

protocol CollectionCellController {
    func cell(for collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell
    func display()
    func endDisplay()
}

class NativeBannerCellController: CollectionCellController {
    let imageUrl: String
    private var cell: NativeBannerCell?
    
    init(imageUrl: String) {
        self.imageUrl = imageUrl
    }
    
    func display() {
        cell?.setImage(imageUrl: imageUrl)
    }
    
    func cell(for collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: NativeBannerCell.nativeBannerIdentifier, for: indexPath)
        cell = myCell as? NativeBannerCell
        return myCell
    }
    
    func endDisplay() {
        cell = nil
    }
}

struct CollectionSectionController {
    var cellControllers: [CollectionCellController]
}

class ViewController: UIViewController {
    
    private let cellIdentifier : String = String(describing: UICollectionViewCell.self)
    
    var sectionsData : [CollectionSectionController] = []
    
    lazy var viewFrame = self.view.frame
    
    lazy var creator = UIHomeScreenCreator(parentController: self, parentFrame: self.viewFrame)
    
    var homeScreenCollectionView : UICollectionView?
    
    var homeScreenManager = HomeScreenManager()
    
    var homeScreenCollectionViewCreator = HomeScreenCollectionViewCreator()
    
    var homeSectionController : HomeSectionController?

    var timer : Timer?
    
    var currentCellIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeScreenManager.delegate = self

        homeScreenManager.getHomeData()
        
        initRootView()
        
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(slideToNext), userInfo: nil, repeats: true)
    }

    func initRootView() {
        let rootView = creator.getView()
        
        homeScreenCollectionView = creator.getCollectionView()
        homeScreenCollectionView?.dataSource = self
        homeScreenCollectionView?.delegate = self
        homeScreenCollectionView?.isPagingEnabled = true
        
        view.addSubview(rootView)
        
        rootViewConstraints(rootView)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        homeScreenCollectionView.frame = view.bounds
        
        setHeightForGradientBackground()
    }
    
    func setHeightForGradientBackground() {
        guard let section = homeSectionController?.getIndexPathSection(sectionName: .Services) else { return }
        
        guard let collectionView = homeScreenCollectionView,
              let cell = collectionView.cellForItem(at: IndexPath(item: 1, section: section))
        else { return }
        
        let targetFrame = collectionView.convert(cell.frame, to: view)
        creator.getSectionHeight(targetFrame)
    }
    
    func rootViewConstraints(_ rootView : UIView) {
        
        let constraints = [
            rootView.topAnchor.constraint(equalTo: view.topAnchor),
            rootView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            rootView.leftAnchor.constraint(equalTo: view.leftAnchor),
            rootView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc func slideToNext() {
        
        let section = homeSectionController?.getIndexPathSection(sectionName: .Slider) ?? 3
        
        currentCellIndex = (currentCellIndex + 1) % 3
        
        homeScreenCollectionView?.scrollToItem(at: IndexPath(item: currentCellIndex, section: section), at: .centeredHorizontally, animated: true)
    }
    
}

extension ViewController : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sectionsData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sectionsData[section].cellControllers.count
//        return homeSectionController?.setupHomeScreenSections(section: section) ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let initCell = collectionView.dequeueReusableCell(withReuseIdentifier: K.initialCellIdentifier, for: indexPath)
//        let cell = homeSectionController?.setupHomeScreenCell(collectionView, cellForItemAt: indexPath)
//
//        return cell ?? initCell
        
        return cellController(at: indexPath).cell(for: collectionView, indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cellController(at: indexPath).display()
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cellController(at: indexPath).endDisplay()
    }
    
    private func cellController(at indexPath: IndexPath) -> CollectionCellController {
        return sectionsData[indexPath.section].cellControllers[indexPath.item]
    }
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: secondIdentifier, for: indexPath)
//        return header
//    }

}

extension ViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       print("User tapped on item \(indexPath.row)")
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        homeScreenCollectionView?.cellForItem(at: <#T##IndexPath#>)
        if scrollView == homeScreenCollectionView {
            let contentOffset = scrollView.contentOffset.y
            creator.updateGradientBackgroundHeight(contentOffset)
            if(contentOffset >= view.safeAreaInsets.top + creator.getTopScreenInnerHeight()) {
                creator.animateTopScreen()
            } else {
                creator.clearAnimateTopScreen()
            }
        }
    }
}


extension ViewController : HomeScreenManagerDelegate {
    func didSetBackgroundForHomeScreen(urlBackground: String) {
        DispatchQueue.main.async { [weak self] in
            let imageUrlString = urlBackground
            let imageUrl:URL = URL(string: imageUrlString)!
            let imageData:NSData = NSData(contentsOf: imageUrl)!
            
            self?.view.backgroundColor = UIColor(patternImage: UIImage(data: imageData as Data)!)
        }
    }
    
    func didGetSectionsList(sectionsData: [SectionModel]) {
        self.sectionsData = sectionsData.map {
            switch $0.type {
            case "native_banner":
                let imageUrl = $0.metaData?["image_url"] as? String
                let cellController = NativeBannerCellController(imageUrl: imageUrl ?? "")
                return CollectionSectionController(cellControllers: [cellController])
                
            case "trip":
                let cellController = TransportCellController(imageUrl: imageUrl ?? "")
                return CollectionSectionController(cellControllers: [cellController])
                
            default:
                return CollectionSectionController(cellControllers: [])
            }
            
        }
        self.homeSectionController = HomeSectionController(sectionsData: sectionsData)
        DispatchQueue.main.async { [weak self] in
            self?.homeScreenCollectionView?.reloadData()
        }
    }
}

