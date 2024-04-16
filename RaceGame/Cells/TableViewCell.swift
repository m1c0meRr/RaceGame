//
//  TableViewCell.swift
//  RaceGame
//
//  Created by Sergey Savinkov on 14.03.2024.
//

import Foundation
import UIKit

class TableViewCell: UITableViewCell {
    
    private let cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "green")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Vasya"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let scoreLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    static let idCollectionViewCell = "idCollectionViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setConstraints()
    }
    
    private func setupViews() {
        self.backgroundColor = .lightGray
        
        addSubview(cellImageView)
        addSubview(nameLabel)
        addSubview(scoreLabel)
    }
    
    public func cellConfigure(model: User) {
        cellImageView.image = UIImage(named: "\(model.avatar)")
        nameLabel.text = model.name
        scoreLabel.text = "\(model.score)"
    }
    
    private func setConstraints(){
        
        NSLayoutConstraint.activate([
            cellImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            cellImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            cellImageView.widthAnchor.constraint(equalToConstant: 50),
            cellImageView.heightAnchor.constraint(equalToConstant: 50),
            
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            scoreLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            scoreLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
