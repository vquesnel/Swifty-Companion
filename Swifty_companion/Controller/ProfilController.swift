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
    let projectCellId = "projectCellId"
    let skillCellId = "skillCellId"
    
    let titles : [String] = ["Profil", "Projects", "Skills"]
    
    var target : String?
    var user : User?
    
    var scrollX : CGFloat = {
        return  0
    }()
    
    var menuHeight : CGFloat = {
        return 40
    }()
    
    var currentIndex : Int = {
        return 0
    }()
    
    lazy var menuBar : Menu = {
        var menu = Menu()
        menu.translatesAutoresizingMaskIntoConstraints = false
        menu.layer.cornerRadius = 5
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
        navigationTitle.textColor = UIColor.rgb(red: 236, green: 236, blue: 236)
        navigationTitle.text = titles[0]
        navigationTitle.textAlignment = .center
        navigationTitle.font = UIFont.systemFont(ofSize: 20.0)
        
        navigationController?.navigationBar.barTintColor =  UIColor.rgb(red: 29, green: 186, blue: 187)
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = UIColor.rgb(red: 236, green: 236, blue: 236)
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue): UIColor.white
        ]
        navigationItem.titleView = navigationTitle
        
        collectionView?.register(UserView.self, forCellWithReuseIdentifier: userCellId)
        collectionView?.register(ProjectsView.self, forCellWithReuseIdentifier: projectCellId)
        collectionView?.register(SkillsView.self, forCellWithReuseIdentifier: skillCellId)
        collectionView?.contentInset = UIEdgeInsets(top: menuHeight, left: 0, bottom: 0, right: 0)
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: menuHeight, left: 0, bottom: 0, right: 0)
        collectionView?.isPagingEnabled = true
        
        view.addSubview(menuBar)
        menuBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        menuBar.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        menuBar.heightAnchor.constraint(equalToConstant: menuHeight).isActive = true
    }
    
    func scrollToMenuIndex(index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        collectionView?.scrollToItem(at: indexPath, at: [], animated: true)
        currentIndex = index
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
        let index = targetContentOffset.pointee.x / view.frame.width
        let indexPath = IndexPath(item: Int(index), section: 0)
        
        menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
        currentIndex = Int(index)
        setTitleForMenuIndex(index: Int(index))
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {        
        switch indexPath.item {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: userCellId, for: indexPath) as! UserView
            cell.user = user
            return cell
        case 1 :
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: projectCellId, for: indexPath) as! ProjectsView
            cell.projects = user?.projects
            return cell
        default :
             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: skillCellId, for: indexPath) as! SkillsView
             cell.skills = user?.cursus[0].skills
             return cell
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - menuHeight)
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        let x = self.scrollX / self.view.frame.width
        coordinator.animate(alongsideTransition: { [unowned self] _ in
            self.collectionView?.collectionViewLayout.invalidateLayout()
            self.menuBar.collectionView.collectionViewLayout.invalidateLayout()
            self.menuBar.horizontalBarLeftAnchor?.constant = self.view.frame.width * x
            self.menuBar.collectionView.collectionViewLayout.invalidateLayout()
            self.scrollToMenuIndex(index: self.currentIndex)
            }, completion: { _ in
                self.scrollX = x * self.view.frame.width
        })
    }
}
