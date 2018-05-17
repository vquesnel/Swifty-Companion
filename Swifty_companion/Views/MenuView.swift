//
//  Menu.swift
//  Swifty_companion
//
//  Created by victor quesnel on 07/05/2018.
//  Copyright © 2018 victor quesnel. All rights reserved.
//


import UIKit

class Menu: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let menuCellID = "menuBarButton"
    let menuBarLogoNames = ["account", "project", "skill"]
    
    var horizontalBarLeftAnchor : NSLayoutConstraint?
    var profilController : ProfilController?
    
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isScrollEnabled = false
        view.backgroundColor = .none
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.isOpaque = false
        
        addSubview(collectionView)
        backgroundColor = UIColor.rgb(red: 29, green: 186, blue: 187)
        
        let selectedPath = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedPath, animated: false, scrollPosition: [])
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: menuCellID)
        setConstraint()
        setHorizontalBar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setHorizontalBar() {
        let horizontalBar = UIView()
        horizontalBar.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.4)
        horizontalBar.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(horizontalBar)
        
        horizontalBarLeftAnchor = horizontalBar.leftAnchor.constraint(equalTo: self.leftAnchor)
        horizontalBarLeftAnchor?.isActive = true
        horizontalBar.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        horizontalBar.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/3).isActive = true
        horizontalBar.heightAnchor.constraint(equalToConstant: 4).isActive = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: menuCellID, for: indexPath) as! MenuCell
        cell.logo.image = UIImage(named: menuBarLogoNames[indexPath.item])?.withRenderingMode(.alwaysTemplate)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 3, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        profilController?.scrollToMenuIndex(index: indexPath.item)
    }
    
    func setConstraint() {
        
        collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        
    }
}
