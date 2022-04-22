//
//  HomeNavigation.swift
//  beclone
//
//  Created by duc.vu1 on 18/04/2022.
//

import UIKit
import FrameLayoutKit

class HomeNavigation : UIView {

    private lazy var welcomeLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Chào Vũ Mạnh Đức!"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    private lazy var bePointButton : UIButton = {
       let uiButton = UIButton()
        uiButton.translatesAutoresizingMaskIntoConstraints = false
        uiButton.backgroundColor = UIColor(red: 94/255, green: 109/255, blue: 132/255, alpha: 0.5)
//        let viewSize = UIScreen.main.bounds.size
//        let buttonSize = uiButton.sizeThatFits(viewSize)
//        uiButton.contentHorizontalAlignment = .center
//        uiButton.frame = CGRect(x: 0, y: 0, width: buttonSize.width + 30, height: buttonSize.height)
//
//        uiButton.imageView?.image = UIImage(named: "Icon-Color-bePoint")
//        uiButton.titleLabel?.text = "100.000"
//        uiButton.contentEdgeInset
//        uiTap
        return uiButton
    }()
    
    private lazy var bePointAmount : UILabel = {
        let uiLabel = UILabel()
        uiLabel.translatesAutoresizingMaskIntoConstraints = false
        uiLabel.text = "100.000"
        uiLabel.font = UIFont.boldSystemFont(ofSize: 14)
        uiLabel.textColor = .white
        
        let parentSize = UIScreen.main.bounds.size
        
        let labelAmountSize = uiLabel.sizeThatFits(parentSize)
        
        uiLabel.frame.size = CGSize(width: labelAmountSize.width, height: labelAmountSize.height)
        return uiLabel
    }()
    private lazy var bePointIcon : UIImageView = {
        let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
//        icon.frame.size = CGSize(width: 16.67, height: 16.67)
        icon.contentMode = .scaleAspectFit
        icon.image = UIImage(named: "Icon-Color-bePoint")
        return icon
    }()

     
    private lazy var homeNavigationInner : UIView = {
        let inner = UIView()
        inner.translatesAutoresizingMaskIntoConstraints = false
//        inner.backgroundColor = .green
        return inner
    }()
    
    private var frameLayouts = VStackLayout()

    override init(frame : CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .orange

        addSubview(welcomeLabel)
//        addSubview(bePointIcon)
//        addSubview(bePointAmount)
        
        frameLayouts.with {
            ($0 + 0).flexible()
            $0 + HStackLayout {
                $0 + welcomeLabel
                ($0 + 0).flexible()
//                ($0 + bePointButton)
                $0 + HStackLayout {
                    $0.backgroundColor = UIColor(red: 94/255, green: 109/255, blue: 132/255, alpha: 0.5)
                    $0 + bePointAmount
                    $0 + 7.67
                    $0 + bePointIcon
                    $0.padding(top: 6, left: 12, bottom: 6, right: 12)
                    
//                    $0.layer.cornerRadius = $0.bounds.size.height / 2
                    $0.didLayoutSubviews {
                        $0.layer.cornerRadius = $0.bounds.size.height / 2
                        $0.layer.masksToBounds = true
                    }
                }
                    
            }
//            $0.debug = true
            $0.padding(top: 0, left: 16, bottom: 12, right: 16)
        }
        
        addSubview(frameLayouts)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let targetFrame = frameLayouts.sizeThatFits(self.bounds.size)
        print(targetFrame)
        frameLayouts.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: targetFrame.height + safeAreaInsets.top + 70)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func toggleBackground(flag : Bool) {
        UIView.animate(withDuration: 0.3) { [weak self] in
            if flag {
                self?.backgroundColor = .white
                self?.setDarkColor()
            }
            else {
                self?.backgroundColor = .clear
                self?.setLightColor()
            }
        }
    }
    
    private func setDarkColor() {
        let darkColor = UIColor(red: 8/255, green: 31/255, blue: 66/255, alpha: 1)
        self.welcomeLabel.textColor = darkColor
        self.bePointAmount.textColor = darkColor
        
    }
    
    private func setLightColor() {
        let lightColor = UIColor.white
        self.welcomeLabel.textColor = lightColor
        self.bePointAmount.textColor = lightColor
    }
}
