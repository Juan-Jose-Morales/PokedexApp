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
            ZStack {
                color
                    .opacity(0.3)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer()
                    AsyncImage(url: URL(string: pokemon.sprites.front_default)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 250, height: 250)
                    } placeholder: {
                        ProgressView()
                    }
                    .padding()
                    .background(color.opacity(0.7))
                    .cornerRadius(20)
                    .shadow(radius: 10)
                    
                    VStack(spacing: 20) {
                        Text("Name: \(pokemon.name.capitalized)")
                            .font(.title)
                            .bold()
                            .foregroundColor(.white)
                        
                        Text("Height: \(pokemon.height)")
                            .font(.title2)
                            .bold()
                            .foregroundColor(.white)
                        
                        Text("Weight: \(pokemon.weight)")
                            .font(.title2)
                            .bold()
                            .foregroundColor(.white)
                    }
                    .padding()
                    
                    Spacer()
                }
            }
            .navigationTitle(pokemon.name.capitalized)
            .navigationBarTitleDisplayMode(.inline)
        }
    }



