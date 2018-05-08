//
//  ProjectCell.swift
//  Swifty_companion
//
//  Created by victor quesnel on 08/05/2018.
//  Copyright © 2018 victor quesnel. All rights reserved.
//


import UIKit

class ProjectCell : UITableViewCell {
    
    let name : UILabel = {
        let label = UILabel()
        label.text = nil
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let grade : UILabel = {
        let label = UILabel()
        label.text = nil
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let gradeLogo : UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.tintColor =  UIColor.rgb(red: 214, green: 100, blue: 113)
        view.image = UIImage(named: "fail")?.withRenderingMode(.alwaysTemplate)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .none
        
        addSubview(name)
        addSubview(grade)
        addSubview(gradeLogo)
        
        name.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        name.trailingAnchor.constraint(equalTo: gradeLogo.leadingAnchor, constant: -20).isActive = true
        name.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        gradeLogo.trailingAnchor.constraint(equalTo: grade.leadingAnchor, constant: -10).isActive = true
        gradeLogo.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        gradeLogo.heightAnchor.constraint(equalToConstant: 15).isActive = true
        gradeLogo.widthAnchor.constraint(equalToConstant: 15).isActive = true
        
        grade.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        grade.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

