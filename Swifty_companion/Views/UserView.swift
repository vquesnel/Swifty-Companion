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
        willSet {
            let view = UIImageView()
            view.image = UIImage(named: "default")
            view.clipsToBounds = true
            view.contentMode = .scaleAspectFill
            self.tableView.backgroundView = view
        }
        didSet {
            guard let id = self.user?.id else { return }
            guard let request = APIServices.shared.createRequest(for: "/users/\(id)/coalitions") else { return }
            RequestService.shared.get(req: request, for: [Coalition].self) { [unowned self] data in
                if let data = data {
                    if data.count > 0 {
                        let view = UIImageView()
                        view.image = UIImage(named: data[0].slug)
                        view.clipsToBounds = true
                        view.contentMode = .scaleAspectFill
                        self.tableView.backgroundView = view
                    }
                }
            }
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
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.tableView.scrollRectToVisible(CGRect(x: 0, y: 0,  width: 1, height: 1), animated: false)

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
