//
//  PokemonModel.swift
//  PokedexApp
//
//  Created by Juan jose Morales on 22/10/24.
//

import Foundation

struct PokemonModel: Codable, Hashable {
    
    let id: Int
    let attack: Int
    let defense: Int
    let description: String
    let name: String
    let type: String
}
