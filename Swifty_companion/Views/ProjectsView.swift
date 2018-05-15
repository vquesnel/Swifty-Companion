//
//  ProjectsView.swift
//  Swifty_companion
//
//  Created by victor quesnel on 08/05/2018.
//  Copyright © 2018 victor quesnel. All rights reserved.
//

import UIKit

class ProjectsView: UICollectionViewCell, UITableViewDataSource, UITableViewDelegate {
    
    var projects : [Project]? {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    let cellId = "cellId"
    
    lazy var tableView : UITableView = {
        let view = UITableView(frame: frame)
        view.allowsSelection = false
        view.delegate = self
        view.dataSource = self
        view.separatorColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.tableView.scrollRectToVisible(CGRect(x: 0, y: 0,  width: 1, height: 1), animated: false)
        addSubview(tableView)
        
        tableView.register(ProjectCell.self, forCellReuseIdentifier: cellId)
        
        tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.backgroundColor = UIColor.rgb(red: 30, green: 30, blue: 30)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ProjectCell
        cell.backgroundColor = indexPath.item % 2 == 1 ? .none : UIColor(white: 0, alpha: 0.2)
        
        guard let data = projects else { return cell }
        guard let grade = data[indexPath.item].finalMark else { return cell }
        guard let validated = data[indexPath.item].validated else { return cell }
        let name = data[indexPath.item].infos.name
        
        cell.name.text = name
        cell.grade.text = String(grade)
        cell.grade.textColor = validated ? UIColor.rgb(red: 95, green: 183, blue: 96) : UIColor.rgb(red: 214, green: 100, blue: 113)
        cell.gradeLogo.image = validated ? UIImage(named: "done")?.withRenderingMode(.alwaysTemplate) : UIImage(named: "fail")?.withRenderingMode(.alwaysTemplate)
        cell.gradeLogo.tintColor = validated ? UIColor.rgb(red: 95, green: 183, blue: 96) : UIColor.rgb(red: 214, green: 100, blue: 113)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(50)
    }
    
}
