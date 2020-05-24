//
//  ListCell.swift
//  For Readdle by Alex Kulya
//
//  Created by Alexandr Kulya on 23.05.2020.
//  Copyright © 2020 Alexandr Kulya. All rights reserved.
//

import UIKit
import Hero

class ListCell: UITableViewCell {
    
    //MARK: - Setup variables
    // Сделал кастомные UIImageView и UILabel, потому что дефолтные аватары(UIImageView) не прогружались без скролинга.
    var avatar: UIImageView = {
        let avatar = UIImageView()
        avatar.translatesAutoresizingMaskIntoConstraints = false
        return avatar
    }()
    
    var name: UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    
    
    //MARK: - Setup values for variables
    func setupAvatarAndName(person: Person) {
        setupAvatar()
        setupName()
        var personInFunc = person
        personInFunc.avatarUrl.append("?s=50&d=mp")
        name.text = person.name
        DispatchQueue.global(qos: .userInitiated).async {
            guard let imageUrl = URL(string: personInFunc.avatarUrl) else { return }
            guard let imageData = try? Data(contentsOf: imageUrl) else { return }
            DispatchQueue.main.async {
                self.avatar.image = UIImage(data: imageData)
            }
        }
        let status = UIImageView(frame: CGRect(x: 29, y: 32, width: 12, height: 12))
        status.image = UIImage(named: String(person.status.rawValue))
        self.avatar.addSubview(status)
        self.avatar.heroID = person.identifireForHero
    }
    
    
    
    //MARK: - Setup Layouts
    func setupAvatar() {
        self.contentView.addSubview(avatar)
        NSLayoutConstraint.activate([
            avatar.heightAnchor.constraint(equalToConstant: 40),
            avatar.widthAnchor.constraint(equalToConstant: 40),
            avatar.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            avatar.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5)
        ])
    }
    func setupName() {
        self.contentView.addSubview(name)
        NSLayoutConstraint.activate([
            name.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 70),
            name.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
        ])
    }
}

