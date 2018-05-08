//
//  SkillCell.swift
//  Swifty_companion
//
//  Created by victor quesnel on 08/05/2018.
//  Copyright © 2018 victor quesnel. All rights reserved.
//

import UIKit

class SkillCell : UITableViewCell {
    
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

    let progressBar: UIProgressView = {
        let pb = UIProgressView()
        pb.progressTintColor = UIColor.rgb(red: 29, green: 186, blue: 187)
        pb.layer.cornerRadius = 5
        pb.translatesAutoresizingMaskIntoConstraints = false
        return pb
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(name)
        addSubview(grade)
        addSubview(progressBar)
        
        setConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    func setConstraints() {
        name.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        name.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -15).isActive = true
        name.trailingAnchor.constraint(equalTo: grade.leadingAnchor, constant: -20).isActive = true
        
        grade.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        grade.centerYAnchor.constraint(equalTo: name.centerYAnchor).isActive = true
        
        progressBar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        progressBar.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        progressBar.heightAnchor.constraint(equalToConstant: 4).isActive = true
        progressBar.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor, constant: 15).isActive = true
    }
}
