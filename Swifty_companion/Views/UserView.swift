//
//  UserView.swift
//  Swifty_companion
//
//  Created by victor quesnel on 08/05/2018.
//  Copyright © 2018 victor quesnel. All rights reserved.
//

import UIKit

class UserView: UICollectionViewCell, UITableViewDataSource, UITableViewDelegate {
    
    var user : User? {
        didSet {
            tableView.reloadData()
        }
    }
    
    let cellId = "cellId"
    
    lazy var tableView : UITableView = {
        let view = UITableView(frame: frame)
        view.allowsSelection = false
        view.separatorColor = .clear
        view.delegate = self
        view.dataSource = self
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .none
        return view
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.tableView.scrollRectToVisible(CGRect(x: 0, y: 0,  width: 1, height: 1), animated: false)
        let view = UIImageView()
        let image = UIImage(named: "default")
        view.image = image
        view.contentMode = .scaleAspectFill
        backgroundView = view
        addSubview(tableView)
    
        tableView.register(UserCell.self, forCellReuseIdentifier: cellId)
        tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(500)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! UserCell
        cell.user = self.user
        return cell
    }
}
