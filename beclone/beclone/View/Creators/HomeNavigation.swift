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
        label.text = "Chào Vũ Mạnh Đức!"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    private lazy var bePointAmount : UILabel = {
        let uiLabel = UILabel()
        uiLabel.text = "100.000"
        uiLabel.font = UIFont.boldSystemFont(ofSize: 14)
        uiLabel.textColor = .white
        return uiLabel
    }()
    private lazy var bePointIcon : UIImageView = {
        let icon = UIImageView()
        icon.contentMode = .scaleAspectFit
        icon.image = UIImage(named: "Icon-Color-bePoint")
        return icon
    }()
    
    private var frameLayouts = HStackLayout()

    override init(frame : CGRect) {
        super.init(frame: frame)
        
        addSubview(welcomeLabel)
        
        frameLayouts.with {
            ($0 + welcomeLabel)
            ($0 + 0).flexible()
            $0 + HStackLayout {
                $0.backgroundColor = UIColor(red: 94/255, green: 109/255, blue: 132/255, alpha: 0.5)
                $0 + bePointAmount
                $0 + 7.67
                $0 + bePointIcon
                $0.padding(top: 6, left: 12, bottom: 6, right: 12)
                
//              $0.layer.cornerRadius = $0.bounds.size.height / 2
                $0.didLayoutSubviews {
                    $0.layer.cornerRadius = $0.bounds.size.height / 2
                    $0.layer.masksToBounds = true
                }
            }
            $0.alignment.vertical = .bottom
            $0.padding(top: 16 , left: 16, bottom: 12, right: 16)
//            $0.debug = true
            
        }
        addSubview(frameLayouts)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        frameLayouts.edgeInsets.top = safeAreaInsets.top + 12
        frameLayouts.frame = bounds
        
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return frameLayouts.sizeThatFits(size)
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
