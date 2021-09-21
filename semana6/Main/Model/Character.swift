//
//  Character.swift
//  semana6
//
//  Created by Linder Hassinger on 21/09/21.
//

import Foundation

class Character: Codable {
    // Tu vas a tener un hijo llamado results
    let results: [Results]
}

class Results: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let image: String
}
