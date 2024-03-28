//
//  AvatarCollectionView.swift
//  RaceGame
//
//  Created by Sergey Savinkov on 09.03.2024.
//

import UIKit

protocol SelectAvatar: UIViewController {
    func selectAvatar(image: UIImage, name: String)
}

class AvatarCollectionView: UIViewController {
    
    private var avatarArray = ["black", "cap", "dead", "doc", "groot", "hulk", "iron", "spider", "thor", "vision","aqua", "aquag", "bat", "cyborg", "flash", "green", "superg", "superm", "wonder"]
    
    private let avatarCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .red
        collectionView.bounces = false
        collectionView.showsVerticalScrollIndicator = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    var heroArray = [String]()
    weak var selectAvatarDelegate: SelectAvatar?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
        setDelegates()
    }
    
    private func setupViews() {
        
        view.backgroundColor = .blue
        
        view.addSubview(avatarCollectionView)
        
        avatarCollectionView.register(AvatarCollectionViewCell.self, forCellWithReuseIdentifier: AvatarCollectionViewCell.collectionViewCellID)
    }
    
    private func setDelegates() {
        avatarCollectionView.dataSource = self
        avatarCollectionView.delegate = self
    }
}

// MARK: - UICollectionViewDataSource

extension AvatarCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        avatarArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AvatarCollectionViewCell.collectionViewCellID, for: indexPath) as? AvatarCollectionViewCell else { return UICollectionViewCell()}
        
        let avatarModel = avatarArray[indexPath.row]
        cell.imageName = avatarModel
        cell.cellImageView.image = UIImage(named: avatarModel)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension AvatarCollectionView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as? AvatarCollectionViewCell
        
        let vc = SettingsViewController()
        guard let image = cell?.cellImageView.image else { return }
        guard let name = cell?.imageName else { return }
        selectAvatarDelegate?.selectAvatar(image: image, name: name)
        vc.avatarImageView.image = image
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension AvatarCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        CGSize(width: collectionView.frame.width / 4,
               height: collectionView.frame.width / 4)
    }
}

// MARK: - setConstraints

extension AvatarCollectionView {
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            
            avatarCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            avatarCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            avatarCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            avatarCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
        ])
    }
}


