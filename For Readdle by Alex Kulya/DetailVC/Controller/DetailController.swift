//
//  DetailController.swift
//  For Readdle by Alex Kulya
//
//  Created by Alexandr Kulya on 09.05.2020.
//  Copyright © 2020 Alexandr Kulya. All rights reserved.
//

import UIKit
import Hero

class DetailController: UIViewController {
    
    //MARK: - Setup variables
    var person: Person!
    
    var avatarImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    var nameLabel: UILabel = {
        let name = UILabel()
        name.font = .systemFont(ofSize: 36)
        name.textAlignment = .center
        name.translatesAutoresizingMaskIntoConstraints =  false
        return name
    }()
    
    let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Back", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        return button
    }()
    
    @objc func goBack() {
        dismiss(animated: true)
    }
    
    var statusLabel: UILabel = {
        let status = UILabel()
        status.textAlignment = .center
        status.font = .systemFont(ofSize: 20)
        return status
    }()
    
    var emailLabel: UILabel = {
        let email = UILabel()
        email.textAlignment = .center
        email.font = .systemFont(ofSize: 28)
        email.textColor = .link
        return email
    }()
    
    
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupButton()
        
        DispatchQueue.global(qos: .userInteractive).sync {
            self.person.avatarUrl.append("?s=200&d=mp")
            guard let imageUrl = URL(string: self.person.avatarUrl) else { return }
            guard let imageData = try? Data(contentsOf: imageUrl) else { return }
            DispatchQueue.main.async {
                self.avatarImage.image = UIImage(data: imageData)
            }
        }
        avatarImage.heroID = person.identifireForHero
        nameLabel.text = person.name
        avatarImage.contentMode = .scaleAspectFit
        emailLabel.text = person.email
        switch person.status.rawValue {
        case 0:
            statusLabel.text = "offline"
        default:
            statusLabel.text = "online"
        }
    }
    
    
    
    //MARK: - Setup Layouts
     func setupButton() {
        view.addSubview(backButton)
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            backButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
     func setupLayout() {
        let topImageConteinerView = UIView()
        view.addSubview(topImageConteinerView)
        topImageConteinerView.translatesAutoresizingMaskIntoConstraints = false
        topImageConteinerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topImageConteinerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        topImageConteinerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        topImageConteinerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4).isActive = true
        topImageConteinerView.addSubview(avatarImage)
        
        avatarImage.centerXAnchor.constraint(equalTo: topImageConteinerView.centerXAnchor).isActive = true
        avatarImage.bottomAnchor.constraint(equalTo: topImageConteinerView.bottomAnchor).isActive = true
        avatarImage.heightAnchor.constraint(equalTo: topImageConteinerView.heightAnchor, multiplier: 0.6).isActive = true
        
        let labelConteinerStackView = UIStackView(arrangedSubviews: [nameLabel, statusLabel, emailLabel])
        view.addSubview(labelConteinerStackView)
        labelConteinerStackView.distribution = .fillEqually
        labelConteinerStackView.axis = .vertical
        labelConteinerStackView.translatesAutoresizingMaskIntoConstraints = false
        labelConteinerStackView.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: 30).isActive = true
        labelConteinerStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        labelConteinerStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
}
