//
//  ContentView.swift
//  PokedexApp
//
//  Created by Juan jose Morales on 22/10/24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = PokemonViewModel()
    @State private var searchText: String = ""
    
    let columns = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
        
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Pokedex")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                TextField("Search Pokemon", text: $searchText)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing:20) {
                            ForEach(viewModel.pokemons.filter { searchText.isEmpty || $0.name.contains(searchText.lowercased()) }) { pokemon in
                                NavigationLink(destination: PokemonDetailView(pokemon: pokemon, color: viewModel.backgroundColor(for: pokemon.types.first?.type.name ?? "unknown"))) {
                                    PokemonCell(pokemon: pokemon, color: viewModel.backgroundColor(for: pokemon.types.first?.type.name ?? "unknown"))
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .onAppear {
                viewModel.loadPokemons()
            }
        }
    }
}


#Preview {
    ContentView()
}
