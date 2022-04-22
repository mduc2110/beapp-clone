//
//  ViewController.swift
//  beclone
//
//  Created by duc.vu1 on 04/04/2022.
//

import UIKit
import FrameLayoutKit


struct CollectionSectionController {
    var cellControllers: [CollectionCellController]
}

class ViewController: UIViewController {
    
    private let cellIdentifier : String = String(describing: UICollectionViewCell.self)
    
    var sectionsData : [CollectionSectionController] = []
    
//    var sectionsData : [SectionModel] = []
    
    lazy var viewFrame = self.view.frame
    
//    lazy var creator = UIHomeScreenCreator(parentController: self, parentFrame: self.viewFrame)
    
    var homeScreenCollectionViewCreator = HomeScreenCollectionViewCreator()
    
    var homeScreenCollectionView : UICollectionView?
    
    var homeScreenManager = HomeScreenManager()
    
//    var collectionView = HomeCollectionView()
    
    private lazy var collectionView : UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let cv = HomeCollectionView(frame: .zero, collectionViewLayout: layout)
//        cv.tran
        return cv
    }()
    
    private lazy var uiGradientBackground : UIView = {
        let background = UIView()
        background.backgroundColor = .white
        background.layer.cornerRadius =  6
//        rootView.backgroundColor = .orange
        return background
    }()
    
    private lazy var bgr : UIView = {
        let ui = UIView()
        ui.backgroundColor = .none
//        rootView.uiColor = .orange
        return ui
    }()
    
    private lazy var labell : UILabel = {
        let ui = UILabel()
        ui.backgroundColor = .green
        ui.text = "Label"
//        rootView.uiColor = .orange
        return ui
    }()
    
    private let frameLayouts = VStackLayout()
    
    private var backgroundFrameLayout = HStackLayout()
    
    var homeNavigation = HomeNavigation()
    
    var topBackgroundConstraints : NSLayoutConstraint?
    
    var defaultGradientBackgroundHeight : CGFloat? = 394
    
    var height2 : CGFloat?
    
//    var homeSectionController : HomeSectionController?

    var timer : Timer?
    
    var currentCellIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        
        homeScreenManager.delegate = self
        homeScreenManager.getHomeData()
        
//        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(slideToNext), userInfo: nil, repeats: true)
//        let controller = UIViewController()
//        view.addSubview(controller.view)
//        didMove(toParent: <#T##UIViewController?#>)
        
    }

    func initView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        
        view.addSubview(uiGradientBackground)
        
        backgroundFrameLayout.with {
            ($0 + uiGradientBackground).flexible()
        }
 
        view.addSubview(homeNavigation)
        view.addSubview(collectionView)
        
        view.addSubview(bgr)
        
//        frameLayouts.removeAll()
        
        frameLayouts.with {
            ($0 + homeNavigation)
            ($0 + collectionView).flexible()
        }
        
        view.addSubview(frameLayouts)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        homeScreenCollectionView.frame = view.bounds
//        let targetFrame = frameLayouts.sizeThatFits(view.bounds.size)
        frameLayouts.frame = view.bounds//CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        
        print(collectionView.frame)
        print(collectionView.numberOfSections)
        
        
        setHeightForGradientBackground()
    }
    
    func setHeightForGradientBackground() {
        guard topBackgroundConstraints == nil else { return } //topBackground is only set one time
//        guard let cell = collectionView.cellForItem(at: IndexPath(item: 0, section: 2)) else { return }
        
//        let targetFrame = collectionView.convert(cell.frame, to: view)
//
//        let safeHeightInset = targetFrame.origin.y - 16
        
//        defaultGradientBackgroundHeight = safeHeightInset
//        addBackgroundConstraints(safeHeightInset)

        backgroundFrameLayout.edgeInsets.top = defaultGradientBackgroundHeight!
        backgroundFrameLayout.frame = view.bounds
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

    func updateGradientBackgroundHeight(_ contentOffset : CGFloat) {
        
//        topBackgroundConstraints?.constant = defaultGradientBackgroundHeight! - contentOffset
        backgroundFrameLayout.removeAll()
        backgroundFrameLayout.edgeInsets.top = defaultGradientBackgroundHeight! - contentOffset
        height2 = defaultGradientBackgroundHeight! - contentOffset
        backgroundFrameLayout.frame = view.bounds
//        uiGradientBackground.layoutIfNeeded()

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
        guard scrollView == collectionView else { return }
        
        let contentOffset = scrollView.contentOffset.y
        updateGradientBackgroundHeight(contentOffset)

//        print(view.safeAreaInsets.top)
        if contentOffset >= homeNavigation.bounds.height && homeNavigation.bounds.height != 0 {
            homeNavigation.toggleBackground(flag: true)
        } else {
            homeNavigation.toggleBackground(flag: false)
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
                let imageBannerList = [
                    "https://drivadz.vn/media/uploads/cms/47180256_309663653211557_5252010709629272064_n.png",
                    "https://drivadz.vn/media/uploads/cms/47180256_309663653211557_5252010709629272064_n.png",
                    "https://drivadz.vn/media/uploads/cms/47180256_309663653211557_5252010709629272064_n.png"
                ]
                
                let cellController = BannerController(imageList: imageBannerList)
                return CollectionSectionController(cellControllers: [cellController,
//                 cellController, cellController])
                ])
                
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

