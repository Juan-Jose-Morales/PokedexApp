//
//  PokemonDetailView.swift
//  PokedexApp
//
//  Created by Juan jose Morales on 23/10/24.
//

import SwiftUI

struct PokemonDetailView: View {
    let pokemon: PokemonModel
    let color: Color
    
    var body: some View {
        VStack {
            AsyncImage (url: URL(string: pokemon.sprites.front_default)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width:200, height: 200)
 
            } placeholder: {
                ProgressView()
            }
            .padding()
            .background(color)
            .cornerRadius(15)
            
            Text("Name: \(pokemon.name.capitalized)")
            Text("Height: \(pokemon.height)")
            Text("Weight: \(pokemon.weight)")
            
            Spacer()
        }
        .navigationTitle(pokemon.name.capitalized)
        .navigationBarTitleDisplayMode(.inline)
        .padding()
        .background(color.opacity(0.3))
    }
}

