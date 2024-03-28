//
//  RecordsViewController.swift
//  RaceGame
//
//  Created by Sergey Savinkov on 15.02.2024.
//

import UIKit

class RecordsViewController: UITableViewController {
    private var userModel = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setUsers()
    }
    
    private func setupViews() {
        title = "Рекорды"
        view.backgroundColor = .green
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.idCollectionViewCell)
    }
    
    private func setUsers() {
        let users = DataBase.shared.users
        userModel = users
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        userModel.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.idCollectionViewCell, for: indexPath) as? TableViewCell else { return UITableViewCell() }
        let model = userModel[indexPath.row]
        cell.cellConfigure(model: model)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
}
