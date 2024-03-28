//
//  GameViewController.swift
//  RaceGame
//
//  Created by Sergey Savinkov on 15.02.2024.
//

import UIKit

class GameViewController: UIViewController {
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "road")
        imageView.clipsToBounds = true
        imageView.alpha = 0.8
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let barrierLeftImageView: UIImageView = {
        let image = UIImage(named: "car1")
        let view = UIImageView(image: image)
        view.frame = CGRect(x: 125, y: -100, width: 60, height: 60)
        view.contentMode = .scaleAspectFit
        view.isUserInteractionEnabled = true
        view.alpha = 1.0
        return view
    }()
    
    private let barrierRightImageView: UIImageView = {
        let image = UIImage(named: "car1")
        let view = UIImageView(image: image)
        view.frame = CGRect( x: 205, y: -100, width: 60, height: 60)
        view.contentMode = .scaleAspectFit
        view.isUserInteractionEnabled = true
        view.alpha = 1.0
        return view
    }()
    
    private let carImageView: UIImageView = {
     //   let image = UIImage(named: "Car0")
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Car0")
        imageView.frame = CGRect(x: 125, y: 600, width: 60, height: 60)
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        imageView.alpha = 1.0
        return imageView
    }()
    
    private let leftButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white.withAlphaComponent(0.35)
        button.setImage(UIImage(systemName: "arrowshape.left.fill"), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.borderColor = UIColor.blue.cgColor
        button.layer.borderWidth = 6
//        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let rightButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white.withAlphaComponent(0.35)
        button.setImage(UIImage(systemName: "arrowshape.right.fill"), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.borderColor = UIColor.blue.cgColor
        button.layer.borderWidth = 6
//        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let startButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        button.setTitle("START", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 40)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let scoreLabel: UILabel = {
        let label = UILabel()
        label.text = "CЧЕТ: 0"
//        label.backgroundColor = .white
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var speed = 1.0
    var score = 0
    var crash = false
    private var timer: Timer?
    private var timer1: Timer?
    var duration = 5.0
    var delay = 1.0
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
       
        rightButton.layer.cornerRadius = rightButton.frame.width / 2
        leftButton.layer.cornerRadius = leftButton.frame.width / 2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
      //  guard let user = DataBase.shared.activeUser else { return }
    
    //  print(user.car)
        
        setTarget()
        setupViews()
        setupConstraints()
        setUser()
    }
    
    private func setupViews() {
        view.backgroundColor = .blue
        
        view.addSubview(backgroundImageView)
        view.addSubview(scoreLabel)
        view.addSubview(startButton)
        view.addSubview(barrierLeftImageView)
        view.addSubview(barrierRightImageView)
        view.addSubview(carImageView)
        view.addSubview(leftButton)
        view.addSubview(rightButton)
        
        navigationItem.backButtonTitle = "Exit"
        navigationController?.navigationBar.tintColor = .black
    }
    
    private func setUser() {
        guard let user = DataBase.shared.activeUser else { return }
        
        carImageView.image = UIImage(named: "car\(user.car)")
        
        speed = user.speed
      
        if speed != 0.0 {
            speed += 3.0
        }
        
        print(user.speed)
        print(user.score)
    }
    
    private func moveCarsBarrier(carBarrier: UIImageView) {
       
        UIView.animate(withDuration: 1.0,
                       delay: 3.0,
                       animations: { () -> Void in
            carBarrier.frame.origin.y += self.view.frame.height
        }, completion: { (finished: Bool) -> Void in
           
             
            carBarrier.frame.origin.y = self.view.frame.height
           
            if self.crash != true {
                self.score += 1
                self.scoreLabel.text = "CЧЕТ:\(self.score)"
            }
        })
    }
    
    private func moveCars() {
        UIView.animate(withDuration: 3.0,
                       delay: 0.0,
                       options: [.curveLinear, .repeat],
                       animations: { () -> Void in
            self.timer?.invalidate()
            self.timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true, block: { (_) in
                self.move()
            })
        })
    }
    
    private func crashObserver() {
        
        self.timer1?.invalidate()
        self.timer1 = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true, block: { (_) in
            if self.carImageView.layer.presentation()!.frame.intersects(self.barrierLeftImageView.layer.presentation()!.frame) || self.carImageView.layer.presentation()!.frame.intersects(self.barrierRightImageView.layer.presentation()!.frame)  {
                self.crash(scoreInt: self.score)
            } else {
               // print("Wruuuumm-m-m")
            }
        })
    }
    
    private func crash(scoreInt: Int) {
        guard let user = DataBase.shared.activeUser else { return }
        DataBase.shared.saveScore(user: user, newScore: scoreInt)
        
        print("SCORE:", user.score)
        self.alertOkCancel(title:  "Игра окончена!", message: "Ваш счет \(scoreInt)") {
            UIView.animate(withDuration: 1) {
                self.startButton.isHidden = false
            }
        }
        
        self.crash = true
        UIView.animate(withDuration: 1) {
            self.carImageView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
            self.leftButton.backgroundColor = .gray
            self.rightButton.backgroundColor = .gray
        }
        rightButton.isEnabled = false
        leftButton.isEnabled = false
    }
    
    private func move() {
      
        if crash != true {
            let imageRand = Int.random(in: 0...7)
            
            self.barrierLeftImageView.image = UIImage(named: "car\(imageRand)")
            self.barrierRightImageView.image = UIImage(named: "car\(imageRand)")
            // }
            
            switch Int.random(in: 0...1) {
            case 0:
                print("move left")
                
                self.moveCarsBarrier(carBarrier: self.barrierLeftImageView)
            case 1:
                print("move right")
                self.moveCarsBarrier(carBarrier: self.barrierRightImageView)
                
            default:
                break
            }
        }
    }
    
    private func setTarget() {
        leftButton.addTarget(self, action: #selector(leftButtonTapped), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(rightButtonTapped), for: .touchUpInside)
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            scoreLabel.topAnchor.constraint(equalTo: backgroundImageView.topAnchor, constant: 50),
            scoreLabel.centerXAnchor.constraint(equalTo: backgroundImageView.centerXAnchor),
            
            startButton.centerYAnchor.constraint(equalTo: backgroundImageView.centerYAnchor),
            startButton.centerXAnchor.constraint(equalTo: backgroundImageView.centerXAnchor),
            startButton.widthAnchor.constraint(equalToConstant: 300),
            startButton.heightAnchor.constraint(equalToConstant: 120),
            
            leftButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            leftButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            leftButton.widthAnchor.constraint(equalToConstant: 100),
            leftButton.heightAnchor.constraint(equalToConstant: 100),
            
            rightButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            rightButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            rightButton.widthAnchor.constraint(equalToConstant: 100),
            rightButton.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
    
    @objc private func startButtonTapped() {
     
        self.crash = false
            UIView.animate(withDuration: 0.2) {
                self.carImageView.transform = .identity
                self.startButton.isHidden = true
                self.moveCars()
                self.crashObserver()
                self.leftButton.backgroundColor = .white.withAlphaComponent(0.35)
                self.rightButton.backgroundColor = .white.withAlphaComponent(0.35)
                self.score = 0
                self.scoreLabel.text = "CЧЕТ:\(self.score)"
        }
        self.rightButton.isEnabled = true
        self.leftButton.isEnabled = true
    }
    
    @objc private func leftButtonTapped() {
        if crash != true {
            UIView.animate(withDuration: 0.3) {
                self.carImageView.frame.origin.x -= 80
            }
        }
    }
    
    @objc private func rightButtonTapped() {
        if crash != true {
            UIView.animate(withDuration: 0.3) {
                self.carImageView.frame.origin.x += 80
            }
        }
    }
}
