//
//  SearchController.swift
//  Swifty_companion
//
//  Created by victor quesnel on 04/05/2018.
//  Copyright © 2018 victor quesnel. All rights reserved.
//


import UIKit

class SearchController : UIViewController, UITextFieldDelegate {
    
    let cellId = "cellId"
    
    lazy var profilController : ProfilController = {
        let layout = UICollectionViewFlowLayout()
        var controller = ProfilController(collectionViewLayout: layout)
        return controller
    }()
    
    let searchInput : UITextField = {
        let field = UITextField()
        field.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.15).cgColor
        field.layer.borderWidth = 1
        field.attributedPlaceholder = NSAttributedString(string: "Search for a login", attributes: [NSAttributedStringKey.foregroundColor : UIColor.rgb(red: 236, green: 236, blue: 236, alpha: 0.7)])
        field.autocapitalizationType = .none
        field.layer.cornerRadius = 5
        field.textAlignment = .center
        field.textColor = UIColor.rgb(red: 236, green: 236, blue: 236)
        field.keyboardAppearance = .dark
        field.autocorrectionType = .no
        field.returnKeyType = .search
        field.backgroundColor = UIColor(white: 0, alpha: 0.3)
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    let schoolImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .clear
        imageView.image = UIImage(named: "42_logo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let searchButton : UIButton = {
        let button = UIButton()
        button.setTitle("search", for: .normal)
        button.backgroundColor = UIColor.rgb(red: 29, green: 186, blue: 187)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(handleSearch), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
        
        let bg = UIImageView(frame: UIScreen.main.bounds)
        bg.image = UIImage(named: "default")
        bg.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.addSubview(bg)
        view.addSubview(searchInput)
        view.addSubview(searchButton)
        view.addSubview(schoolImage)
        
        initializeTextFields()
        setConstraints()
    }
    
    @objc func handleSearch() {
        searchButton.isEnabled = false;
        guard let login = searchInput.text?.trim() else { return }
        self.profilController.target = login
        guard let request = APIServices.shared.createRequest(for: "/users/\(login)") else { return }
        RequestService.shared.get(req: request, for: User.self) { [unowned self] data in
            if let data = data {
                self.profilController.user = data
                self.navigationController?.pushViewController(self.profilController, animated: true)
                self.profilController.scrollToMenuIndex(index: 0)
                self.profilController.menuBar.collectionView.collectionViewLayout.invalidateLayout()
                self.profilController.menuBar.collectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: [])
                self.searchButton.isEnabled = true;
                self.profilController.collectionView?.reloadData()
                self.searchInput.text = ""
            }
            else {
                let alert = UIAlertController(title: "Error", message: "This login doesn't exists", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                self.searchButton.isEnabled = true;
                print("login doesn't exist... Try another one!")
            }
        }
    }
    
    func setConstraints() {
        schoolImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        schoolImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        schoolImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        schoolImage.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -155).isActive = true
        
        searchInput.heightAnchor.constraint(equalToConstant: 50).isActive = true
        searchInput.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -33).isActive = true
        searchInput.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 33).isActive = true
        searchInput.topAnchor.constraint(equalTo: schoolImage.safeAreaLayoutGuide.bottomAnchor, constant: 35).isActive = true
        
        searchButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        searchButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -33).isActive = true
        searchButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 33).isActive = true
        searchButton.topAnchor.constraint(equalTo: searchInput.safeAreaLayoutGuide.bottomAnchor, constant: 35).isActive = true
    }
    
    func initializeTextFields() {
        searchInput.delegate = self
        searchInput.keyboardType = UIKeyboardType.asciiCapable
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        coordinator.animate(alongsideTransition: { [unowned self] _ in
            self.viewLayoutMarginsDidChange()
            }, completion: { _ in
        })
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        handleSearch()
        return true;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
}
