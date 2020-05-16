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

    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    var person: Person!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        emailLabel.text = person.email
        switch person.status.rawValue {
        case 0:
            statusLabel.text = "offline"
        default:
            statusLabel.text = "online"
        }
    }
    
    deinit {}

}
