//
//  ViewController.swift
//  beclone
//
//  Created by duc.vu1 on 04/04/2022.
//

import UIKit



struct CollectionSectionController {
    var cellControllers: [CollectionCellController]
}

class ViewController: UIViewController {
    
    private let cellIdentifier : String = String(describing: UICollectionViewCell.self)
    
    var sectionsData : [CollectionSectionController] = []
    
//    var sectionsData : [SectionModel] = []
    
    lazy var viewFrame = self.view.frame
    
    lazy var creator = UIHomeScreenCreator(parentController: self, parentFrame: self.viewFrame)
    
    var homeScreenCollectionViewCreator = HomeScreenCollectionViewCreator()
    
    var homeScreenCollectionView : UICollectionView?
    
    var homeScreenManager = HomeScreenManager()
    
//    var collectionView = HomeCollectionView()
    
    lazy var collectionView : UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let cv = HomeCollectionView(frame: view.frame, collectionViewLayout: layout)
        return cv
    }()
    
    lazy var uiGradientBackground : UIView = {
        let background = UIView()
        background.translatesAutoresizingMaskIntoConstraints = false
        background.backgroundColor = .white
        background.layer.cornerRadius =  6
//        rootView.backgroundColor = .orange
        return background
    }()
    
    var homeNavigation = HomeNavigation()
    
    var topBackgroundConstraints : NSLayoutConstraint?
    
    var defaultGradientBackgroundHeight : CGFloat?
    
//    var homeSectionController : HomeSectionController?

    var timer : Timer?
    
    var currentCellIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        
        homeScreenManager.delegate = self
        homeScreenManager.getHomeData()
        
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(slideToNext), userInfo: nil, repeats: true)
//        let controller = UIViewController()
//        view.addSubview(controller.view)
//        didMove(toParent: <#T##UIViewController?#>)
        
    }

    func initView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true

        view.addSubview(uiGradientBackground)
        
        view.addSubview(homeNavigation)

        view.addSubview(collectionView)

        addConstraints()
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            homeNavigation.topAnchor.constraint(equalTo: view.topAnchor),
            homeNavigation.leftAnchor.constraint(equalTo: view.leftAnchor),
            homeNavigation.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: homeNavigation.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        homeScreenCollectionView.frame = view.bounds
        
        setHeightForGradientBackground()
    }
    
    func setHeightForGradientBackground() {
//        guard let collectionView = homeScreenCollectionView,
//              let cell = collectionView.cellForItem(at: IndexPath(item: 0, section: 2))
//        else { return }
//
        guard let cell = collectionView.cellForItem(at: IndexPath(item: 0, section: 2))
        else { return }
        
        let targetFrame = collectionView.convert(cell.frame, to: view)
//        creator.setSectionHeight(targetFrame)
        
        setSectionHeight(targetFrame)
    }
    
    func addBackgroundConstraints(_ top : CGFloat) {
        topBackgroundConstraints = uiGradientBackground.topAnchor.constraint(equalTo: view.topAnchor, constant: top)
        
        let constraints = [
            topBackgroundConstraints!,
            uiGradientBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            uiGradientBackground.leftAnchor.constraint(equalTo: view.leftAnchor),
            uiGradientBackground.rightAnchor.constraint(equalTo: view.rightAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
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
    
    
    

    @objc func slideToNext() {

        let section = 3

        currentCellIndex = (currentCellIndex + 1) % 3
        print("😂 \(currentCellIndex)")
        homeScreenCollectionView?.scrollToItem(at: IndexPath(item: currentCellIndex, section: section), at: .centeredHorizontally, animated: true)
    }
    
}

extension ViewController : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sectionsData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sectionsData[section].cellControllers.count
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

}

extension ViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       print("User tapped on item \(indexPath.row)")
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        homeScreenCollectionView?.cellForItem(at: <#T##IndexPath#>)
        
        guard scrollView == homeScreenCollectionView else { return }
        
        let contentOffset = scrollView.contentOffset.y
        creator.updateGradientBackgroundHeight(contentOffset)
        if(contentOffset >= view.safeAreaInsets.top + creator.getTopScreenInnerHeight()) {
            creator.animateTopScreen()
        } else {
            creator.clearAnimateTopScreen()
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
            case .nativeBanner:
                let imageUrl = $0.metaData?["image"] as? String
                let cellController = NativeBannerCellController(imageUrl: imageUrl ?? "")
                return CollectionSectionController(cellControllers: [cellController])

            case .trip:
                let cellController = TransportCellController()
                return CollectionSectionController(cellControllers: [cellController])
            case .grid:
                var cellControllers : [ServicesCellController] = []
                if let safeData = $0.data {
//                    cellControllers = safeData.map { (item) in
//                        return ServicesCellController(services: item)
//                    }

                    for (index, item) in safeData.enumerated() {
                        if index == 10 { break }
                        cellControllers.append(ServicesCellController(services: item))
                        
                    }
                    
                }
                
                return CollectionSectionController(cellControllers: cellControllers)
            case .banner:
                let cellController = BannerController()
                return CollectionSectionController(cellControllers: [cellController, cellController, cellController])
                
            default:
                return CollectionSectionController(cellControllers: [])
            }
        }
//        self.homeSectionController = HomeSectionController(sectionsData: sectionsData)
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
            
//            self?.homeScreenCollectionView?.reloadData()
        }
    }
}

