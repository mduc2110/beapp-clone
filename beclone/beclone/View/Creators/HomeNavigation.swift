//
//  HomeNavigation.swift
//  beclone
//
//  Created by duc.vu1 on 18/04/2022.
//

import UIKit

class HomeNavigation : UIView {
    
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
        
        
//        let viewSize = parentController?.view.bounds.size
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

    
    lazy var uiTopScreenInner : UIView = {
        let inner = UIView()
        inner.translatesAutoresizingMaskIntoConstraints = false
//        inner.backgroundColor = .green
        return inner
    }()

    override init(frame : CGRect) {
        super.init(frame: frame)
//        self.uiRootView = uiRootView
//        self.initHomeNavigation()
    }
    
    func initHomeNavigationView(with uiParentView : UIView){
        initHomeNavigation(uiParentView: uiParentView)
    }
    
    func getHomeNavigationView() -> UIView {
//        print(topScreenView)
        return topScreenView
    }
    
    func getBottomAnchor() -> NSLayoutYAxisAnchor{
        return topScreenView.bottomAnchor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initHomeNavigation(uiParentView : UIView) {
        //add right Bepoint UI to button
        bePointButton.addSubview(bePointAmount)
        bePointButton.addSubview(bePointIcon)
        
        //add button to UI inner
        uiTopScreenInner.addSubview(bePointButton)
        
        //add welcome label to UI inner
        uiTopScreenInner.addSubview(welcomeLabel)
        
        //add inner to top screen UI
        topScreenView.addSubview(uiTopScreenInner)
        //add top screen constraints
        
        //add top screen to UI root view
        uiParentView.addSubview(topScreenView)
        
        addHomeNavigationConstraints(uiParentView: uiParentView)
    }
    
    
    func addHomeNavigationConstraints(uiParentView : UIView) {
        let innerButtonPadding = (bePointButton.bounds.height - 16.67) / 2
        
        let topScreenConstraints = [
            topScreenView.topAnchor.constraint(equalTo: uiParentView.topAnchor),
            topScreenView.leftAnchor.constraint(equalTo: uiParentView.safeAreaLayoutGuide.leftAnchor),
            topScreenView.rightAnchor.constraint(equalTo: uiParentView.safeAreaLayoutGuide.rightAnchor),
            topScreenView.bottomAnchor.constraint(equalTo: uiTopScreenInner.bottomAnchor)
        ]
        NSLayoutConstraint.activate(topScreenConstraints)
        
        
        let welcomeLabelConstraints = [
            welcomeLabel.centerYAnchor.constraint(equalTo: uiTopScreenInner.centerYAnchor),
            welcomeLabel.leftAnchor.constraint(equalTo: uiTopScreenInner.leftAnchor, constant: 16),
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
            bePointButton.rightAnchor.constraint(equalTo: uiTopScreenInner.rightAnchor, constant: -16),
//            bePointButton.widthAnchor.constraint(equalToConstant: innerButtonPadding * 3 + bePointAmount.bounds.width + bePointIcon.bounds.width)
            bePointButton.leftAnchor.constraint(equalTo: bePointAmount.leftAnchor, constant: -(innerButtonPadding + 5)),
            bePointButton.topAnchor.constraint(equalTo: uiTopScreenInner.topAnchor, constant: (innerButtonPadding + 5)),
            bePointButton.bottomAnchor.constraint(equalTo: uiTopScreenInner.bottomAnchor, constant: -(innerButtonPadding + 5)),
            
//            bePointButton.bottomAnchor.constraint(equalTo: uiTopScreenInner.bottomAnchor, constant: -12)
        ]
        NSLayoutConstraint.activate(bePointButtonConstraints)

        let topScreenInnerConstraints = [
            uiTopScreenInner.topAnchor.constraint(equalTo: uiParentView.safeAreaLayoutGuide.topAnchor),
            uiTopScreenInner.bottomAnchor.constraint(equalTo: topScreenView.bottomAnchor),
            uiTopScreenInner.leftAnchor.constraint(equalTo: topScreenView.leftAnchor),
            uiTopScreenInner.rightAnchor.constraint(equalTo: topScreenView.rightAnchor),
        ]
        
        NSLayoutConstraint.activate(topScreenInnerConstraints)
    }
    
    func toggleBackground(flag : Bool) {
        UIView.animate(withDuration: 0.3) {
            if flag {
                self.topScreenView.backgroundColor = .white
                self.welcomeLabel.setBeDarkColor()
                self.bePointAmount.setBeDarkColor()
            }
            else {
                self.topScreenView.backgroundColor = .clear
                self.welcomeLabel.setBeLightColor()
                self.bePointAmount.setBeLightColor()
            }
        }
    }
    
    func getNavigationInnerHeight() -> CGFloat{
        return uiTopScreenInner.bounds.height
    }
}
