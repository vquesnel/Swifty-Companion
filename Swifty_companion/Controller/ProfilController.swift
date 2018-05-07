//
//  ProfileController.swift
//  Swifty_companion
//
//  Created by victor quesnel on 04/05/2018.
//  Copyright © 2018 victor quesnel. All rights reserved.
//


import UIKit

class ProfilController : UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let userCellId = "userCellId"
    let titles : [String] = ["Profil", "Projects", "Skills"]
    
    var target : String?
    var user : User?
    
    var cursus: Int?
    
    var scrollX : CGFloat = {
        return  0
    }()
    
    lazy var menuBar : Menu = {
        var menu = Menu()
        menu.translatesAutoresizingMaskIntoConstraints = false
        menu.layer.cornerRadius = 16
        menu.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        menu.clipsToBounds = true
        menu.profilController = self
        return menu
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        let navigationTitle = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        navigationTitle.textColor = .white
        navigationTitle.text = "Profil"
        navigationTitle.font = UIFont.systemFont(ofSize: 20.0)
        
        
        navigationController?.navigationBar.barTintColor =  UIColor.rgb(red: 29, green: 186, blue: 187)
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue): UIColor.white
        ]
        navigationItem.titleView = navigationTitle
        
        collectionView?.register(UserCell.self, forCellWithReuseIdentifier: userCellId)
        collectionView?.contentInset = UIEdgeInsets(top: 80, left: 0, bottom: 0, right: 0)
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 80, left: 0, bottom: 0, right: 0)
        collectionView?.isPagingEnabled = true
        view.addSubview(menuBar)
        
        menuBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        menuBar.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        menuBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
    
        
    }
    
    func scrollToMenuIndex(index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        collectionView?.scrollToItem(at: indexPath, at: [], animated: true)
        
        setTitleForMenuIndex(index: index)
    }
    
    private func setTitleForMenuIndex(index: Int) {
        if let title = navigationItem.titleView as? UILabel {
            title.text = "\(titles[Int(index)])"
        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollX =  scrollView.contentOffset.x / 3
        menuBar.horizontalBarLeftAnchor?.constant = scrollX
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let index = targetContentOffset.move().x / view.frame.width
        let indexPath = IndexPath(item: Int(index), section: 0)
        
        menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
        
        setTitleForMenuIndex(index: Int(index))
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: userCellId, for: indexPath) as! UserCell
        cell.user = self.user
        let view = UIImageView()
        view.image = UIImage(named: "default")
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        cell.backgroundView = view
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
}







