//
//  PokemonModel.swift
//  PokedexApp
//
//  Created by Juan jose Morales on 22/10/24.
//

import Foundation

struct PokemonModel: Decodable, Identifiable {
    
    let id: Int
    let name: String
    let types: [PokemonTypeEntry]
    let weight: Int
    let height: Int
    let sprites: Sprite
}

struct Sprite: Decodable {
    let front_default: String
}

struct PokemonTypeEntry: Decodable {
    let type: PokemonType
}

struct PokemonType: Decodable {
    let name: String
}

struct PokemonListResponse: Decodable {
    let results: [PokemonEntry]
}

struct PokemonEntry: Decodable {
    let name: String
    let url: String
}
