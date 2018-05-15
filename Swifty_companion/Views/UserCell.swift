//
//  UserCell.swift
//  Swifty_companion
//
//  Created by victor quesnel on 07/05/2018.
//  Copyright © 2018 victor quesnel. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
    var user : User? {
        willSet {
            let view = UIImageView()
            view.image = UIImage(named: "default")
            view.clipsToBounds = true
            view.contentMode = .scaleAspectFill
            self.backgroundView = view
            picture.image = UIImage()
            name.text = "N/A"
            campusLocation.text = "N/A"
            wallet.text = "N/A"
            correctionPoint.text = "N/A"
        }
        
        didSet {
            downloadImage()
            name.text = self.user?.displayName
            if let location = self.user?.location { self.location.text = location }
            if let login = self.user?.login { self.login.text = login }
            if let phone = self.user?.phone { self.phone.text = phone }
            if let mail = self.user?.email { self.email.text = mail }
            if let correction = self.user?.correctionPoint { self.correctionPoint.text = String(correction) }
            if let wallet = self.user?.wallet { self.wallet.text = String(wallet) }
            if let campusLocation = self.user?.campus[0].name { self.campusLocation.text = campusLocation }
            if let level = self.user?.cursus[0].level {
                self.level.text = "level - \(level) %"
                self.progressBar.progress = Float(level.truncatingRemainder(dividingBy: 1.0))
            }
            guard let id = self.user?.id else { return }
            guard let request = APIServices.shared.createRequest(for: "/users/\(id)/coalitions") else { return }
            RequestService.shared.get(req: request, for: [Coalition].self) { [unowned self] data in
                if let data = data {
                    if data.count > 0 {
                        let view = UIImageView()
                        view.image = UIImage(named: data[0].slug)
                        view.clipsToBounds = true
                        view.contentMode = .scaleAspectFill
                        self.backgroundView = view
                    }
                }
            }
        }
    }
    
    let topShadowView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.6)
        view.layer.cornerRadius = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let bottomShadowView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.6)
        view.layer.cornerRadius = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let picture : UIImageView = {
        let view = UIImageView()
        view.backgroundColor = UIColor.rgb(red: 30, green: 30, blue: 30)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage()
        view.layer.borderColor = UIColor.white.cgColor
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 70
        view.clipsToBounds = true
        return view
    }()
    
    let name : UILabel = {
        let label = UILabel()
        label.text = "Display Name"
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let login : UILabel = {
        let label = UILabel()
        label.text = "login"
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let location: UILabel = {
        let label = UILabel()
        label.text = "Unavailable"
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let progressBar: UIProgressView = {
        let pb = UIProgressView()
        pb.progressTintColor = UIColor.rgb(red: 29, green: 186, blue: 187)
        pb.progress = 0.45
        pb.layer.cornerRadius = 5
        pb.translatesAutoresizingMaskIntoConstraints = false
        return pb
    }()
    
    let level : UILabel = {
        let label = UILabel()
        label.text = "level - 0.0%"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let phoneImage : UIImageView = {
        let view = UIImageView()
        view.tintColor = .white
        view.image = UIImage(named: "phone")?.withRenderingMode(.alwaysTemplate)
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let phone : UILabel = {
        let label = UILabel()
        label.text = "N/A"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let emailImage : UIImageView = {
        let view = UIImageView()
        view.tintColor = .white
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        view.image = UIImage(named: "mail")?.withRenderingMode(.alwaysTemplate)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let email : UILabel = {
        let label = UILabel()
        label.text = "N/A"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let locationImage : UIImageView = {
        let view = UIImageView()
        view.tintColor = .white
        view.image = UIImage(named: "location")?.withRenderingMode(.alwaysTemplate)
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let campusLocation : UILabel = {
        let label = UILabel()
        label.text = "N/A"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let walletImage : UIImageView = {
        let view = UIImageView()
        view.tintColor = .white
        view.image = UIImage(named: "wallet")?.withRenderingMode(.alwaysTemplate)
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let wallet : UILabel = {
        let label = UILabel()
        label.text = "N/A"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let correctionImage : UIImageView = {
        let view = UIImageView()
        view.tintColor = .white
        view.image = UIImage(named: "correction")?.withRenderingMode(.alwaysTemplate)
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let correctionPoint : UILabel = {
        let label = UILabel()
        label.text = "N/A"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(topShadowView)
        topShadowView.addSubview(picture)
        topShadowView.addSubview(login)
        topShadowView.addSubview(name)
        topShadowView.addSubview(location)
        topShadowView.addSubview(progressBar)
        progressBar.addSubview(level)
        
        addSubview(bottomShadowView)
        bottomShadowView.addSubview(phone)
        bottomShadowView.addSubview(phoneImage)
        bottomShadowView.addSubview(email)
        bottomShadowView.addSubview(emailImage)
        bottomShadowView.addSubview(campusLocation)
        bottomShadowView.addSubview(locationImage)
        bottomShadowView.addSubview(wallet)
        bottomShadowView.addSubview(walletImage)
        bottomShadowView.addSubview(correctionPoint)
        bottomShadowView.addSubview(correctionImage)

        setConstraint()
    }
    
    func downloadImage() {
        guard let url = user?.imageUrl else { return }
        RequestService.shared.imageDownloader(url: url) { image in
            guard let imageDownloaded = image else { return }
            self.picture.image = imageDownloaded
        }
    }
        
    func setConstraint() {
        
        topShadowView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40).isActive = true
        topShadowView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        topShadowView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        topShadowView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        topShadowView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        picture.widthAnchor.constraint(equalToConstant: 140).isActive = true
        picture.heightAnchor.constraint(equalToConstant: 140).isActive = true
        picture.leadingAnchor.constraint(equalTo: topShadowView.leadingAnchor, constant: 10).isActive = true
        picture.centerYAnchor.constraint(equalTo: topShadowView.centerYAnchor, constant: -20).isActive = true
        
        name.leadingAnchor.constraint(equalTo: picture.trailingAnchor, constant: 5).isActive = true
        name.topAnchor.constraint(equalTo: topShadowView.topAnchor, constant: 40).isActive = true
        name.trailingAnchor.constraint(equalTo: topShadowView.trailingAnchor, constant: -10).isActive = true
        
        login.leadingAnchor.constraint(equalTo: picture.trailingAnchor, constant: 5).isActive = true
        login.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 10).isActive = true
        login.trailingAnchor.constraint(equalTo: topShadowView.trailingAnchor, constant: -10).isActive = true

        location.leadingAnchor.constraint(equalTo: picture.trailingAnchor, constant: 5).isActive = true
        location.topAnchor.constraint(equalTo: login.bottomAnchor, constant: 10).isActive = true
        location.trailingAnchor.constraint(equalTo: topShadowView.trailingAnchor, constant: -10).isActive = true
        
        progressBar.topAnchor.constraint(equalTo: picture.bottomAnchor, constant: 10).isActive = true
        progressBar.leadingAnchor.constraint(equalTo: topShadowView.leadingAnchor, constant: 10).isActive = true
        progressBar.trailingAnchor.constraint(equalTo: topShadowView.trailingAnchor, constant: -10).isActive = true
        progressBar.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        level.centerXAnchor.constraint(equalTo: progressBar.centerXAnchor).isActive = true
        level.centerYAnchor.constraint(equalTo: progressBar.centerYAnchor).isActive = true
        
        bottomShadowView.topAnchor.constraint(equalTo: topShadowView.bottomAnchor, constant: 40).isActive = true
        bottomShadowView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        bottomShadowView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        bottomShadowView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        bottomShadowView.heightAnchor.constraint(equalToConstant: 150).isActive = true

        phone.leadingAnchor.constraint(equalTo: phoneImage.trailingAnchor, constant: 20).isActive = true
        phone.centerYAnchor.constraint(equalTo: phoneImage.centerYAnchor).isActive = true
        
        phoneImage.leadingAnchor.constraint(equalTo: bottomShadowView.leadingAnchor, constant: 20).isActive = true
        phoneImage.topAnchor.constraint(equalTo: bottomShadowView.topAnchor, constant: 30).isActive = true
        phoneImage.widthAnchor.constraint(equalToConstant: 16).isActive = true
        phoneImage.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        email.leadingAnchor.constraint(equalTo: emailImage.trailingAnchor, constant: 20).isActive = true
        email.centerYAnchor.constraint(equalTo: emailImage.centerYAnchor).isActive = true
        
        emailImage.leadingAnchor.constraint(equalTo: bottomShadowView.leadingAnchor, constant: 20).isActive = true
        emailImage.topAnchor.constraint(equalTo: phoneImage.bottomAnchor, constant: 20).isActive = true
        emailImage.widthAnchor.constraint(equalToConstant: 16).isActive = true
        emailImage.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        campusLocation.centerYAnchor.constraint(equalTo: locationImage.centerYAnchor).isActive = true
        campusLocation.leadingAnchor.constraint(equalTo: locationImage.trailingAnchor, constant: 20).isActive = true
        
        locationImage.leadingAnchor.constraint(equalTo: bottomShadowView.leadingAnchor, constant: 20).isActive = true
        locationImage.topAnchor.constraint(equalTo: emailImage.bottomAnchor, constant: 20).isActive = true
        locationImage.widthAnchor.constraint(equalToConstant: 16).isActive = true
        locationImage.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        wallet.centerYAnchor.constraint(equalTo: walletImage.centerYAnchor).isActive = true
        wallet.trailingAnchor.constraint(equalTo: walletImage.leadingAnchor, constant: -20).isActive = true
        
        walletImage.trailingAnchor.constraint(equalTo: bottomShadowView.trailingAnchor, constant: -20).isActive = true
        walletImage.topAnchor.constraint(equalTo: bottomShadowView.topAnchor, constant: 30).isActive = true
        walletImage.widthAnchor.constraint(equalToConstant: 16).isActive = true
        walletImage.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        correctionPoint.centerYAnchor.constraint(equalTo: correctionImage.centerYAnchor).isActive = true
        correctionPoint.trailingAnchor.constraint(equalTo: correctionImage.leadingAnchor, constant: -20).isActive = true

        correctionImage.trailingAnchor.constraint(equalTo: bottomShadowView.trailingAnchor, constant: -20).isActive = true
        correctionImage.centerYAnchor.constraint(equalTo: locationImage.centerYAnchor).isActive = true
        correctionImage.widthAnchor.constraint(equalToConstant: 16).isActive = true
        correctionImage.heightAnchor.constraint(equalToConstant: 16).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

