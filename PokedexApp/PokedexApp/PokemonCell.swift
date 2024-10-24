//
//  PokemonCell.swift
//  PokedexApp
//
//  Created by Juan jose Morales on 23/10/24.
//

import Foundation
import SwiftUI

struct PokemonCell: View {
    let pokemon: PokemonModel
    let color: Color
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: pokemon.sprites.front_default)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80, height: 80)
            } placeholder: {
                ProgressView()
            }
            Text(pokemon.name.capitalized)
                .font(.caption)
                .foregroundColor(.black)
                
        }
        .padding()
        .background(color)
        .cornerRadius(15)
    }
}
