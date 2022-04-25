//
//  SliderCell.swift
//  beclone
//
//  Created by duc.vu1 on 14/04/2022.
//

import Foundation
import UIKit
import FrameLayoutKit


class BannerCell : UICollectionViewCell {
    static let bannerCellIdentifier = "bannerCellIdentifier"
    static let bannerItemCellIdentifier = "bannerItemCellIdentifier"
    private var timer : Timer?
    private var currentCellIndex = 0
    private var source : [BannerVCCellController] = []
    private var imageBannerList : [String]?
    private let frameLayout = VStackLayout()
    
    private lazy var bannerCollectionView : UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        var collectionView = UICollectionView(frame: contentView.frame, collectionViewLayout: layout)
        collectionView.alwaysBounceHorizontal = true
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: BannerCell.bannerItemCellIdentifier)
        collectionView.collectionViewLayout.invalidateLayout()
        collectionView.isPagingEnabled = true
        return collectionView
    }()
    
    private lazy var pageControl : UIPageControl = {
        let pageControlView = UIPageControl()
        return pageControlView
    }()
    
    func initData(data : [String]) {
        imageBannerList = data
        
        source = imageBannerList?.map { BannerVCCellController(urlString: $0) } ?? [BannerVCCellController(urlString: "https://drivadz.vn/media/uploads/cms/47180256_309663653211557_5252010709629272064_n.png")]
        
        pageControl.numberOfPages = imageBannerList?.count ?? 1
        pageControl.currentPage = currentCellIndex
        
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(slideToNext), userInfo: nil, repeats: true)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 6
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = .orange
        
        bannerCollectionView.dataSource = self
        bannerCollectionView.delegate = self
        
        contentView.addSubview(bannerCollectionView)
        contentView.addSubview(pageControl)
        
        frameLayout.with {
            ($0 + bannerCollectionView).flexible()
        }

        contentView.addSubview(frameLayout)
    }
    
    override func layoutSubviews() {
        frameLayout.frame = contentView.bounds
        
        let pageControlTarget = pageControl.sizeThatFits(contentView.bounds.size)

        pageControl.frame = CGRect(
            x: contentView.bounds.size.width / 2 - pageControlTarget.width / 2,
            y: contentView.bounds.height - pageControlTarget.height,
            width: pageControlTarget.width,
            height: pageControlTarget.height)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func slideToNext() {
        let section = 0
        currentCellIndex = (currentCellIndex + 1) % 3
        pageControl.currentPage = currentCellIndex
        bannerCollectionView.scrollToItem(at: IndexPath(item: currentCellIndex, section: section), at: .centeredHorizontally, animated: true)
    }
}


extension BannerCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return source.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return bannerCell(at: indexPath).cell(for: collectionView, indexPath: indexPath)
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        bannerCell(at: indexPath).display()
    }
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        bannerCell(at: indexPath).endDisplay()
    }
    private func bannerCell(at indexPath : IndexPath) -> BannerVCCellController {
        return source[indexPath.row]
    }
}

extension BannerCell : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: contentView.bounds.width, height: contentView.bounds.height )
    }
}
