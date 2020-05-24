//
//  ListController.swift
//  For Readdle by Alex Kulya
//
//  Created by Alexandr Kulya on 23.05.2020.
//  Copyright © 2020 Alexandr Kulya. All rights reserved.
//

import UIKit
import Hero

class ListController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Setup variables
    var personArray = Person.createPersons()
    
    var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["List", "Grid"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.addTarget(self, action: #selector(goToGrid), for: .valueChanged)
        return segmentedControl
    }()
    @objc func goToGrid() {
        if segmentedControl.selectedSegmentIndex == 0 {
            return
        } else {
            performSegue(withIdentifier: "goToGrid", sender: nil)
        }
    }
    
    var changeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Simulate Change", for: .normal)
        button.setTitleColor(.link, for: .normal)
        button.backgroundColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(doChange), for: .touchUpInside)
        return button
    }()
    @objc func doChange() {
        personArray = Person.createPersons()
    }
    
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSegmentedControl()
        setupButton()
    }
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(true)
         tableView.reloadData()
    }
    
    
    
    //MARK: - Setup Layouts
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 70),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -65)
        ])
        tableView.register(ListCell.self, forCellReuseIdentifier: "tableCellId")
    }
    
    func setupSegmentedControl() {
        view.addSubview(segmentedControl)
        NSLayoutConstraint.activate([
            segmentedControl.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.55),
            segmentedControl.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
        ])
    }
    
    func setupButton() {
        view.addSubview(changeButton)
        NSLayoutConstraint.activate([
            changeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            changeButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            changeButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            changeButton.heightAnchor.constraint(equalToConstant: 65)
        ])
    }
    
    
    
    //MARK: - Navigation
    @IBAction func unwindToList(_ unwindSegue: UIStoryboardSegue) {
        self.segmentedControl.selectedSegmentIndex = 0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailFromList" {
            guard let detailVC = segue.destination as? DetailController else { return }
            let person = sender as? Person
            detailVC.person = person
        } else if segue.identifier == "goToGrid" {
            guard let gridVC = segue.destination as? GridController else { return }
            gridVC.personArray = personArray
        }
    }
    
    
    //MARK: - Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let person = personArray[indexPath.row]
        performSegue(withIdentifier: "showDetailFromList", sender: person)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "tableCellId", for: indexPath) as? ListCell {
            let person = personArray[indexPath.row]
            cell.setupAvatarAndName(person: person)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
