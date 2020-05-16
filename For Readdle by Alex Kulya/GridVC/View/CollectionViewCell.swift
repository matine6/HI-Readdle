//
//  CollectionViewCell.swift
//  For Readdle by Alex Kulya
//
//  Created by Alexandr Kulya on 09.05.2020.
//  Copyright © 2020 Alexandr Kulya. All rights reserved.
//

import UIKit
import Hero

class CollectionViewCell: UICollectionViewCell {    
    
    @IBOutlet weak var avatarImage: UIImageView!
    func setupDataOfPersonInCellItem(person: Person) {
        var personInFunc = person
        personInFunc.avatarUrl.append("?s=50&d=mp")
        
        self.frame.size.height = CGFloat(50)
        self.frame.size.width = CGFloat(50)
        
        // Присваиваем статус пользователя и аватар
        DispatchQueue.global(qos: .userInitiated).async {
            guard let imageUrl = URL(string: personInFunc.avatarUrl) else { return }
            guard let imageData = try? Data(contentsOf: imageUrl) else { return }
            DispatchQueue.main.async {
                self.avatarImage.image = UIImage(data: imageData)
            }
        }
        avatarImage.heroID = person.identifireForHero
        
        let status = UIImageView(frame: CGRect(x: 27, y: 27, width: 12, height: 12))
        status.image = UIImage(named: String(person.status.rawValue))
        avatarImage.addSubview(status)
    }
}
