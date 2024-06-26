//
//  UserModel.swift
//  RaceGame
//
//  Created by Sergey Savinkov on 12.03.2024.
//

import Foundation

struct User: Codable {
    let name: String
    let avatar: String
    let car: Int
    var score: Int
    var speed: Double
}
