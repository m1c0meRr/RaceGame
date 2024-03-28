//
//  MainViewController.swift
//  RaceGame
//
//  Created by Sergey Savinkov on 15.02.2024.
//

import UIKit

class MainViewController: UIViewController {
    
    private let gameButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        button.setTitle("Game", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let recordsButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        button.setTitle("Records", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let settingsButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        button.setTitle("Settings", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTarget()
        setupViews()
        setupConstraints()
    }
    
    private func setTarget() {
        gameButton.addTarget(self, action: #selector(gameButtonTapped), for: .touchUpInside)
        recordsButton.addTarget(self, action: #selector(recordsButtonTapped), for: .touchUpInside)
        settingsButton.addTarget(self, action: #selector(settingsButtonTapped), for: .touchUpInside)
    }

    private func setupViews() {
        view.backgroundColor = .gray
        
        view.addSubview(gameButton)
        view.addSubview(recordsButton)
        view.addSubview(settingsButton)
    }
    
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            gameButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            gameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gameButton.widthAnchor.constraint(equalToConstant: 200),
            
            recordsButton.topAnchor.constraint(equalTo: gameButton.bottomAnchor, constant: 50),
            recordsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            recordsButton.widthAnchor.constraint(equalToConstant: 200),
        
            settingsButton.topAnchor.constraint(equalTo: recordsButton.bottomAnchor, constant: 50),
            settingsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            settingsButton.widthAnchor.constraint(equalToConstant: 200),
        ])
    }
    
    
    @objc private func gameButtonTapped() {
            let gameVC = GameViewController()
            navigationItem.backButtonTitle = "Exit"
            navigationController?.pushViewController(gameVC, animated: true)
       
    }
    
    @objc private func recordsButtonTapped() {
        let recordsVC = RecordsViewController()
        navigationItem.backButtonTitle = "" // содержание кнопки назад
        navigationController?.pushViewController(recordsVC, animated: true)
    }
    
    @objc private func settingsButtonTapped() {
        let settingsVC = SettingsViewController()
        navigationItem.backButtonTitle = "" // содержание кнопки назад
        navigationController?.pushViewController(settingsVC, animated: true)
    }
}

