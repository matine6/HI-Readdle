//
//  Person.swift
//  For Readdle by Alex Kulya
//
//  Created by Alexandr Kulya on 09.05.2020.
//  Copyright © 2020 Alexandr Kulya. All rights reserved.
//

import Foundation

struct Person {
    var name: String
    var avatarUrl: String
    var email: String
    var status: Status
    var identifireForHero: String
    
    enum Status: Int {
        case online = 1
        case offline = 0
    }
}

extension Person {
    static func createPersons() -> [Person] {
        var personArray = [Person]()
        DispatchQueue.global(qos: .background).sync {
            let rundomNumberOfPersons = Int.random(in: 70...90)
            let imageUrl = "https://www.gravatar.com/avatar/"
            
            for index in 1...rundomNumberOfPersons {
                let rundomStatus = Int.random(in: 0...1)
                var personInArray = Person(
                    name: "Person Name\(index)",
                    avatarUrl: imageUrl,
                    email: "email\(index)@gmail.com",
                    status: Status(rawValue: rundomStatus)!,
                    identifireForHero: String(index)
                )
                
                // Создаем ссылку на аватар
                var hash = Hasher()
                hash.combine(personInArray.email)
                let hashValue = hash.finalize()
                personInArray.avatarUrl.append(String(hashValue))
                
                personArray.append(personInArray)
            }
        }
        return personArray
    }
}
