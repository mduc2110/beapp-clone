//
//  ViewController.swift
//  beclone
//
//  Created by duc.vu1 on 04/04/2022.
//

import UIKit


class ViewController: UIViewController {
    
    private let cellIdentifier : String = String(describing: UICollectionViewCell.self)
    
    var sectionsData : [SessionModel] = []
    
    lazy var viewFrame = self.view.frame
    
    lazy var creator = UIHomeScreenCreator(parentController: self, parentFrame: self.viewFrame)
    
    var homeScreenCollectionView : UICollectionView?
    
    var homeScreenManager = HomeScreenManager()
    
    var homeScreenCollectionViewCreator = HomeScreenCollectionViewCreator()
    
    var homeSectionController : HomeSectionController?
    
    var cellLayout = UICollectionViewLayout()

    var timer : Timer?
    
    var currentCellIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeScreenManager.delegate = self

        homeScreenManager.getHomeData()
        
        initHomeScreenView()
        
    }

    func initHomeScreenView() {
        initRootView()
    }
    
    func initRootView() {
        let rootView = creator.getView()
        
        homeScreenCollectionView = creator.getCollectionView()
        homeScreenCollectionView?.dataSource = self
        homeScreenCollectionView?.delegate = self
        
        view.addSubview(rootView)
        
        rootViewConstraints(rootView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        homeScreenCollectionView.frame = view.bounds
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
    
    
}

extension ViewController : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeSectionController?.setupHomeScreenSections(section: section) ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let initCell = collectionView.dequeueReusableCell(withReuseIdentifier: K.initialCellIdentifier, for: indexPath)
        
        let cell = homeSectionController?.setupHomeScreenCell(collectionView, cellForItemAt: indexPath)
        
        return cell ?? initCell
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
        
        if scrollView == homeScreenCollectionView {
            let contentOffset = scrollView.contentOffset.y
            if(contentOffset >= view.safeAreaInsets.top + creator.getTopScreenInnerHeight()) {
                creator.animateTopScreen()
            } else {
                creator.clearAnimateTopScreen()
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
    
    func didGetSectionsList(sectionsData: [SessionModel]) {
        self.sectionsData = sectionsData
        self.homeSectionController = HomeSectionController(sessionData: sectionsData)
        DispatchQueue.main.async {
            self.homeScreenCollectionView?.reloadData()
        }
    }
}

