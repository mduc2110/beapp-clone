//
//  HomeNavigation.swift
//  beclone
//
//  Created by duc.vu1 on 18/04/2022.
//

import UIKit

class HomeNavigation : UIView {

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
        let viewSize = UIScreen.main.bounds.size
        let buttonSize = uiButton.sizeThatFits(viewSize)
        uiButton.contentHorizontalAlignment = .center
        uiButton.frame = CGRect(x: 0, y: 0, width: buttonSize.width + 30, height: buttonSize.height)
        
        uiButton.layer.cornerRadius = buttonSize.height / 2
        return uiButton
    }()
    
    lazy var bePointAmount : UILabel = {
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
    lazy var bePointIcon : UIImageView = {
        let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.frame.size = CGSize(width: 16.67, height: 16.67)
        icon.image = UIImage(named: "Icon-Color-bePoint")
        return icon
    }()

    
    lazy var homeNavigationInner : UIView = {
        let inner = UIView()
        inner.translatesAutoresizingMaskIntoConstraints = false
//        inner.backgroundColor = .green
        return inner
    }()

    override init(frame : CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        //add right Bepoint UI to button
        bePointButton.addSubview(bePointAmount)
        bePointButton.addSubview(bePointIcon)
        
        //add button to UI inner
        homeNavigationInner.addSubview(bePointButton)
        
        //add welcome label to UI inner
        homeNavigationInner.addSubview(welcomeLabel)
        
        //add inner to top screen UI
        addSubview(homeNavigationInner)
        //add top screen constraints
        
        addHomeNavigationConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addHomeNavigationConstraints() {
        let innerButtonPadding = (bePointButton.bounds.height - 16.67) / 2

        
        let welcomeLabelConstraints = [
            welcomeLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            welcomeLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            
            welcomeLabel.centerYAnchor.constraint(equalTo: homeNavigationInner.centerYAnchor),
            welcomeLabel.leftAnchor.constraint(equalTo: homeNavigationInner.leftAnchor, constant: 16),
        ]
        NSLayoutConstraint.activate(welcomeLabelConstraints)
        
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
            bePointButton.rightAnchor.constraint(equalTo: homeNavigationInner.rightAnchor, constant: -16),
            bePointButton.leftAnchor.constraint(equalTo: bePointAmount.leftAnchor, constant: -(innerButtonPadding + 5)),
            bePointButton.topAnchor.constraint(equalTo: homeNavigationInner.topAnchor, constant: (innerButtonPadding + 5)),
            bePointButton.bottomAnchor.constraint(equalTo: homeNavigationInner.bottomAnchor, constant: -(innerButtonPadding + 5)),
            welcomeLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor)
        ]
        NSLayoutConstraint.activate(bePointButtonConstraints)

        let topScreenInnerConstraints = [
            homeNavigationInner.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            homeNavigationInner.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            homeNavigationInner.leftAnchor.constraint(equalTo: self.leftAnchor),
            homeNavigationInner.rightAnchor.constraint(equalTo: self.rightAnchor),
        ]

        NSLayoutConstraint.activate(topScreenInnerConstraints)
    }
    
    func toggleBackground(flag : Bool) {
        UIView.animate(withDuration: 0.3) {
            if flag {
                self.backgroundColor = .white
                self.welcomeLabel.setBeDarkColor()
                self.bePointAmount.setBeDarkColor()
            }
            else {
                self.backgroundColor = .clear
                self.welcomeLabel.setBeLightColor()
                self.bePointAmount.setBeLightColor()
            }
        }
    }
}
