//
//  UserDefaultsManager.swift
//  RaceGame
//
//  Created by Sergey Savinkov on 12.03.2024.
//

import Foundation

class DataBase {
    
    static let shared = DataBase()
    
    enum SettingKeys: String {
        case users
        case activeUser
    }
    
    let defaults = UserDefaults.standard
    let userKey = SettingKeys.users.rawValue
    let activeUserKey = SettingKeys.activeUser.rawValue
    
    var users: [User] {
        get {
            if let data = defaults.value(forKey: userKey) as? Data {
                return try! PropertyListDecoder().decode([User].self, from: data)
            } else {
                return [User]()
            }
        }
        set {
            if let data = try? PropertyListEncoder().encode(newValue) {
                defaults.set(data, forKey: userKey)
            }
        }
    }
    
    func saveUser(name: String, car: Int, avatar: String, score: Int, speed: Double) {
        
        let user = User(name: name, avatar: avatar, car: car, score: score, speed: speed)
        
        users.insert(user, at: 0)
        activeUser = user
    }
    
    var activeUser: User? {
        get {
            if let data = defaults.value(forKey: activeUserKey) as? Data {
                return try! PropertyListDecoder().decode(User.self, from: data)
            } else {
                return nil
            }
        }
        set {
            if let data = try? PropertyListEncoder().encode(newValue) {
                defaults.set(data, forKey: activeUserKey)
            }
        }
    }
    
    func saveScore(user: User, newScore: Int) {
        if let someScore = users.firstIndex(where: { $0.name == user.name }) {
            var updateUser = user
            if updateUser.score <= newScore {
                updateUser.score = newScore
                users[someScore] = updateUser
            } else {
                print("SCORE is SMALL!")
            }
        }
    }
}
