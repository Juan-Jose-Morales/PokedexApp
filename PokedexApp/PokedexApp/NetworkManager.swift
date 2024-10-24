//
//  NetworkManager.swift
//  PokedexApp
//
//  Created by Juan jose Morales on 22/10/24.
//

import Foundation
import Combine
import Alamofire

class NetworkManager {
    
    private let baseURL = "https://pokeapi.co/api/v2/pokemon"
    private var cancellables = Set<AnyCancellable>()
    
    func fetchPokemonList(limit: Int) -> AnyPublisher<[PokemonModel], Error> {
        let url = "\(baseURL)?limit=\(limit)"
        return Future<[PokemonModel], Error> { promise in
            AF.request(url)
                .validate()
                .responseDecodable(of: PokemonListResponse.self) { response in
                    switch response.result {
                    case .success(let listResponse):
                        print("Pokemon List Response: \(listResponse)")
                        let pokemonDetailsPublishers = listResponse.results.map { self.fetchPokemonDetails(url: $0.url) }
                        Publishers.MergeMany(pokemonDetailsPublishers)
                            .collect()
                            .sink(receiveCompletion: { completion in
                                if case .failure(let error) = completion {
                                    print("Error in fetching pokemon details: \(error.localizedDescription)")
                                    promise(.failure(error))
                                }
                            }, receiveValue: { pokemons in
                                print("Fetched Pokemons: \(pokemons.count)")
                                promise(.success(pokemons))
                            })
                            .store(in: &self.cancellables)
                    case .failure(let error):
                        print("Error fetching pokemon list: \(error.localizedDescription)")
                        promise(.failure(error))
                    }
                }
        }
        .eraseToAnyPublisher()
    }

    private func fetchPokemonDetails(url: String) -> AnyPublisher<PokemonModel, Error> {
        return Future<PokemonModel, Error> { promise in
            AF.request(url)
                .validate()
                .responseDecodable(of: PokemonModel.self) { response in
                    switch response.result {
                    case .success(let pokemon):
                        promise(.success(pokemon))
                    case .failure(let error):
                        promise(.failure(error))
                    }
                }
        }
        .eraseToAnyPublisher()
    }
}
