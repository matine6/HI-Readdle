//
//  TableController.swift
//  For Readdle by Alex Kulya
//
//  Created by Alexandr Kulya on 09.05.2020.
//  Copyright © 2020 Alexandr Kulya. All rights reserved.
//

import UIKit
import Hero

class TableController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentValue: UISegmentedControl!
    
    var personArray = Person.createPersons()
    var avatar: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        segmentValue.selectedSegmentIndex = 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(true)
         tableView.reloadData()
    }
    
    @IBAction func unwindToList(_ unwindSegue: UIStoryboardSegue) {
        self.segmentValue.selectedSegmentIndex = 0
    }
    
    @IBAction func goToGridSegmelnt(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            return
        default:
            performSegue(withIdentifier: "goToGrid", sender: nil)
        }
    }
    
    @IBAction func changePersons() {
        personArray = Person.createPersons()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailFromList" {
            guard let detailVC = segue.destination as? DetailController else { return }
            let person = sender as? Person
            detailVC.person = person
        } else if segue.identifier == "goToGrid" {
            guard let collectionVC = segue.destination as? CollectionController else { return }
            collectionVC.personArray = personArray
        }
    }
}

extension TableController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell {
            let person = personArray[indexPath.row]
            cell.setupDataOfPersonInCellItem(person: person)
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let person = personArray[indexPath.row]
        performSegue(withIdentifier: "showDetailFromList", sender: person)
    }
    
}


