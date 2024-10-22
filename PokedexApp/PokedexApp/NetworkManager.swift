//
//  NetworkManager.swift
//  PokedexApp
//
//  Created by Juan jose Morales on 22/10/24.
//

import Foundation

enum APError: Error {
    case invalidURL
    case unableToComplete
    case invalidReponse
    case invalidData
    case decodingError
}

class NetworkManager {
    static let baseURL = "https://pokeapi.co/api/v2/pokemon/ditto"
    
    init() {}
    
    func getOflistOfPokemon(completed: @escaping (Result<[PokemonModel], APError>) -> Void ) {
        guard let url = URL(string: NetworkManager.baseURL) else {
            completed(.failure(.invalidURL))
            return
            
        }
        let task = URLSession.shared.dataTask(with: url) {data, _, error in
            
            guard let data = data?.parseData(removeString: "null,") else {
                completed(.failure(.decodingError))
                return
            }
            do {
                let decoder = JSONDecoder()
                let decodeReponse = try decoder.decode([PokemonModel].self, from: data)
                completed(.success(decodeReponse))
            } catch {
                (print("Debug: error: \(error.localizedDescription)"))
                completed(.failure(.decodingError))
            }
        }
        task.resume()
    }
}

extension Data {
    func parseData(removeString word: String) -> Data? {
        let dataAsString = String(data: self, encoding: .utf8)
        let parseDataString = dataAsString?.replacingOccurrences(of: word, with: "")
        guard let data = parseDataString?.data(using: .utf8) else { return nil }
        return data
    }
}
