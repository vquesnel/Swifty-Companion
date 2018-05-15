//
//  SkillsView.swift
//  Swifty_companion
//
//  Created by victor quesnel on 08/05/2018.
//  Copyright © 2018 victor quesnel. All rights reserved.
//

import UIKit
class SkillsView: UICollectionViewCell, UITableViewDataSource, UITableViewDelegate {
    
    var skills : [Skills]? {
        didSet {
            self.tableView.reloadData()
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
        
        tableView.register(SkillCell.self, forCellReuseIdentifier: cellId)
        tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.backgroundColor = UIColor.rgb(red: 30, green: 30, blue: 30)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return skills?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellId,for: indexPath) as! SkillCell
        
        cell.backgroundColor = indexPath.item % 2 == 1 ? .none : UIColor(white: 0, alpha: 0.12)
        
        guard let data = self.skills else { return cell }
        guard let name = data[indexPath.item].name else { return cell }
        let level = data[indexPath.item].level
        cell.name.text = name
        cell.grade.text = String(level)
        cell.grade.textColor = UIColor.rgb(red: 95, green: 183, blue: 96)
        cell.progressBar.progress = Float(level / 20)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(70)
    }
    
}
