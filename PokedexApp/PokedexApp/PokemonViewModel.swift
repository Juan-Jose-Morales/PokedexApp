//
//  PokemonViewModel.swift
//  PokedexApp
//
//  Created by Juan jose Morales on 22/10/24.
//

import Foundation
import Combine
import SwiftUICore

class PokemonViewModel: ObservableObject {
    @Published var pokemons: [PokemonModel] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var selectedPokemon: PokemonModel?
    
    private var cancellables = Set<AnyCancellable>()
    private let networkManager = NetworkManager()
    
    func loadPokemons(limit: Int = 150) {
        isLoading = true
        networkManager.fetchPokemonList(limit: limit)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                self.isLoading = false
                switch completion {
                    case .finished:
                    break
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
                
            },receiveValue: { pokemons in
                self.pokemons = pokemons
            })
            .store(in: &cancellables)
    }
    
    func backgroundColor(for type: String) -> Color {
           switch type {
           case "fire":
               return Color.orange
           case "water":
               return Color.blue
           case "grass":
               return Color.green
           case "electric":
               return Color.yellow
           case "poison":
               return Color.purple
           case "ground":
               return Color.brown
           case "flying":
               return Color.cyan
           default:
               return Color.gray
           }
       }
}
