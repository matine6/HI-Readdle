//
//  GridCell.swift
//  For Readdle by Alex Kulya
//
//  Created by Alexandr Kulya on 23.05.2020.
//  Copyright © 2020 Alexandr Kulya. All rights reserved.
//

import UIKit
import Hero

class GridCell: UICollectionViewCell {
    
    //MARK: - Setup variables
    var avatar: UIImageView = {
        let avatar = UIImageView()
        avatar.translatesAutoresizingMaskIntoConstraints = false
        return avatar
    }()
    
    
    
    //MARK: - Setup values for variables
    func setupDataOfPersonInCellItem(person: Person) {
        setupAvatar()
        var personInFunc = person
        personInFunc.avatarUrl.append("?s=50&d=mp")
        DispatchQueue.global(qos: .userInitiated).async {
            guard let imageUrl = URL(string: personInFunc.avatarUrl) else { return }
            guard let imageData = try? Data(contentsOf: imageUrl) else { return }
            DispatchQueue.main.async {
                self.avatar.image = UIImage(data: imageData)
                let status = UIImageView(frame: CGRect(x: 29, y: 32, width: 12, height: 12))
                status.image = UIImage(named: String(person.status.rawValue))
                self.avatar.addSubview(status)
            }
        }
        self.avatar.heroID = person.identifireForHero
    }
    
    
    
//    MARK: - Setup Layout
    func setupAvatar() {
        self.contentView.addSubview(avatar)
        NSLayoutConstraint.activate([
            avatar.heightAnchor.constraint(equalToConstant: 40),
            avatar.widthAnchor.constraint(equalToConstant: 40),
            avatar.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5),
            avatar.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5)
        ])
    }
}
