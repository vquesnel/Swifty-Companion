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
        label.textColor = UIColor.rgb(red: 236, green: 236, blue: 236)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let grade : UILabel = {
        let label = UILabel()
        label.text = nil
        label.textColor = UIColor.rgb(red: 236, green: 236, blue: 236)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let progressBar: UIProgressView = {
        let pb = UIProgressView()
        pb.progressTintColor = UIColor.rgb(red: 29, green: 186, blue: 187)
        pb.trackTintColor = UIColor.rgb(red: 236, green: 236, blue: 236, alpha: 0.7)
        pb.layer.cornerRadius = 7
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
        grade.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        grade.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -15).isActive = true
        
        name.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        name.centerYAnchor.constraint(equalTo: grade.centerYAnchor).isActive = true
        name.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, constant: -100).isActive = true
        
        progressBar.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        progressBar.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        progressBar.heightAnchor.constraint(equalToConstant: 4).isActive = true
        progressBar.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor, constant: 15).isActive = true
    }
}
