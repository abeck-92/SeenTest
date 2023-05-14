//
//  Pokemon.swift
//  Pokedex
//
//  Created by Austin Beck on 5/12/23.
//

import SwiftUI

class Service {
    static var shared = Service()
    
    let baseURL = "https://pokeapi.co/api/v2/pokemon/?offset=0&limit=250"
    var pokemon = [Pokemon]()
    
    public func fetchPokemon(completion: @escaping (Any) -> ()) {
        guard let endpoint = URL(string: baseURL) else {
            return
        }

        URLSession.shared.dataTask(with: endpoint) { (data, _, error) in
            guard let data = data else {
                return
            }
            let pokemon = try! JSONDecoder().decode(Results.self, from: data)

            DispatchQueue.main.async {
                completion(pokemon)
            }
        }
        .resume()
    }

    public func getSinglePokemon(url: String, completion: @escaping (Any) -> ()) {
        guard let endpoint = URL(string: url) else {
            return
        }

        URLSession.shared.dataTask(with: endpoint) { (data, _, error) in
            guard let data = data else {
                return
            }
            let pokemon = try! JSONDecoder().decode(SinglePokemon.self, from: data)

            DispatchQueue.main.async {
                completion(pokemon)
            }
        }
        .resume()
    }
}
