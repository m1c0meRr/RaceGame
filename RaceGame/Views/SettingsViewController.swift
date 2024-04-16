//
//  SettingsViewController.swift
//  RaceGame
//
//  Created by Sergey Savinkov on 15.02.2024.
//

import UIKit

class SettingsViewController: UIViewController {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["1", "2", "3"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.backgroundColor = .gray
        segmentedControl.selectedSegmentTintColor = .yellow
        let font = UIFont.systemFont(ofSize: 16)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: font as Any,
                                                 NSAttributedString.Key.foregroundColor: UIColor.white],
                                                for: .normal)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: font as Any,
                                                 NSAttributedString.Key.foregroundColor: UIColor.black],
                                                for: .selected)
        segmentedControl.addTarget(self, action: #selector(segmentedChanged), for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()
    
    let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "avatar")
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = imageView.frame.width / 2
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let avatarButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Name"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.text = nil
        textField.placeholder = "your name"
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .always
        textField.keyboardType = .default
        textField.returnKeyType = .default
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let saveNameButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        button.setTitle("save", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let avatarLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Your avatar"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let carLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Your car"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let speedLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Сложность"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let carImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "car0")
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let rightButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.setImage(UIImage(systemName: "arrowshape.right.fill"), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let leftButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.setImage(UIImage(systemName: "arrowshape.left.fill"), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var imageName: String = "spider"
    private var imageCar: String = "car0"
    private var carNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupTarget()
        setupConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = .orange
        
        view.addSubview(scrollView)
        scrollView.addSubview(avatarImageView)
        scrollView.addSubview(avatarButton)
        scrollView.addSubview(nameLabel)
        scrollView.addSubview(nameTextField)
        scrollView.addSubview(carLabel)
        scrollView.addSubview(carImageView)
        scrollView.addSubview(rightButton)
        scrollView.addSubview(leftButton)
        scrollView.addSubview(speedLabel)
        scrollView.addSubview(segmentedControl)
        scrollView.addSubview(saveNameButton)
    }
    
    private func setupTarget() {
        avatarButton.addTarget(self, action: #selector(avatarButtonTapped), for: .touchUpInside)
        saveNameButton.addTarget(self, action: #selector(saveNameButtonTapped), for: .touchUpInside)
        leftButton.addTarget(self, action: #selector(leftButtonTapped), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(rightButtonTapped), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            avatarImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 30),
            avatarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarImageView.heightAnchor.constraint(equalToConstant: 150),
            avatarImageView.widthAnchor.constraint(equalToConstant: 150),
            
            avatarButton.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            avatarButton.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            avatarButton.trailingAnchor.constraint(equalTo: avatarImageView.trailingAnchor),
            avatarButton.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 30),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameLabel.widthAnchor.constraint(equalToConstant: 80),
            
            nameTextField.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            nameTextField.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 16),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            carLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 30),
            carLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            carImageView.topAnchor.constraint(equalTo: carLabel.bottomAnchor, constant: 40),
            carImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            rightButton.centerYAnchor.constraint(equalTo: carImageView.centerYAnchor),
            rightButton.leadingAnchor.constraint(equalTo: carImageView.trailingAnchor, constant: -16),
            rightButton.widthAnchor.constraint(equalToConstant: 100),
            
            leftButton.centerYAnchor.constraint(equalTo: carImageView.centerYAnchor),
            leftButton.trailingAnchor.constraint(equalTo: carImageView.leadingAnchor, constant: 16),
            leftButton.widthAnchor.constraint(equalToConstant: 100),
            
            speedLabel.topAnchor.constraint(equalTo: carImageView.bottomAnchor, constant: 30),
            speedLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            segmentedControl.topAnchor.constraint(equalTo: speedLabel.bottomAnchor, constant: 10),
            segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            saveNameButton.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 50),
            saveNameButton.centerXAnchor.constraint(equalTo: segmentedControl.centerXAnchor),
            saveNameButton.widthAnchor.constraint(equalToConstant: 350),
            saveNameButton.heightAnchor.constraint(equalToConstant: 50),
            saveNameButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -50)
        ])
    }
    
    @objc private func segmentedChanged() {
        if segmentedControl.selectedSegmentIndex == 0 {
            
        } else {
            
        }
    }
    
    @objc private func avatarButtonTapped() {
        let avatarVC = AvatarCollectionView()
        avatarVC.selectAvatarDelegate = self
        if let sheet = avatarVC.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersScrollingExpandsWhenScrolledToEdge = true
            sheet.prefersEdgeAttachedInCompactHeight = true
            sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = false
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 30
        }
        present(avatarVC, animated: true)
    }
    
    @objc private func saveNameButtonTapped() {
        
        let nameText = nameTextField.text ?? ""
        let speed = segmentedControl.selectedSegmentIndex
        
        print(speed)
        if !imageName.isEmpty &&
            !nameText.isEmpty {
            
            DataBase.shared.saveUser(name: nameText, car: carNumber, avatar: imageName, score: 0, speed: Double(speed))
            
            self.alertOk(title: "Успех!", message: "Водитель сохранен")
        } else {
            self.alertOk(title: "Ошибка", message: "Введите имя!")
        }
    }
    
    @objc private func leftButtonTapped() {
        if carNumber != 0 {
            carNumber -= 1
            carImageView.image = UIImage(named: "car\(carNumber)")
        } else {
            carImageView.image = UIImage(named: "car0")
        }
    }
    
    @objc private func rightButtonTapped() {
        if carNumber != 7 {
            carNumber += 1
            carImageView.image = UIImage(named: "car\(carNumber)")
        } else {
            carImageView.image = UIImage(named: "car7")
        }
    }
}

//MARK: - selectAvatar

extension SettingsViewController: SelectAvatar {
    func selectAvatar(image: UIImage, name: String) {
        imageName = name
        avatarImageView.image = image
    }
}
