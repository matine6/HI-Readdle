//
//  GridController.swift
//  For Readdle by Alex Kulya
//
//  Created by Alexandr Kulya on 23.05.2020.
//  Copyright © 2020 Alexandr Kulya. All rights reserved.
//

import UIKit
import Hero

class GridController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    //MARK: - Setup variables
    var personArray: [Person]!
    
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 50, height: 50)
        layout.sectionInset.left = 10
        layout.sectionInset.right = 10
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["List", "Grid"])
        segmentedControl.selectedSegmentIndex = 1
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.addTarget(self, action: #selector(goToList), for: .valueChanged)
        return segmentedControl
    }()
    @objc func goToList() {
        if segmentedControl.selectedSegmentIndex == 1 {
            return
        } else {
            performSegue(withIdentifier: "unwindToList", sender: nil)
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
        setupCollectionView()
        setupSegmentedControl()
        setupButton()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        collectionView.reloadData()
    }
    
    
    
    //MARK: - Setup Layouts
    func setupCollectionView() {
        view.addSubview(collectionView)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 70),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -65)
        ])
        collectionView.register(GridCell.self, forCellWithReuseIdentifier: "collectionViewCell")
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailFromGrid" {
            guard let detailVC = segue.destination as? DetailController else { return }
            let person = sender as? Person
            detailVC.person = person
        } else if segue.identifier == "unwindToList" {
            guard let listVC = segue.destination as? ListController else { return }
            listVC.personArray = self.personArray
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let person = personArray[indexPath.item]
        performSegue(withIdentifier: "showDetailFromGrid", sender: person)
    }
    
    
    
    //MARK: - Delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return personArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as? GridCell {
            let person = personArray[indexPath.item]
            cell.setupDataOfPersonInCellItem(person: person)
            return cell
        }
        return UICollectionViewCell()
    }
}


