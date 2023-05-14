//
//  Pokemon.swift
//  Pokedex
//
//  Created by Austin Beck on 5/12/23.
//

import Foundation
import UIKit

struct Pokemon: Codable {
    var name: String
    let url: String
}

struct Results: Codable {
    let count: Int
    let next: String
    var results: [Pokemon]
}

struct SinglePokemon: Codable {
    let id: Int
    let name: String
    let base_experience: Int
    let forms: [Forms]
    let sprites: Sprites
    let moves: [Moves]
    let types: [Types]
}

struct Types: Codable {
    let slot: Int
    let type: type
}

struct type: Codable {
    let name: String
    let url: String
}

struct Forms: Codable {
    var name: String
    let url: String
}

struct Sprites: Codable {
    let front_default: String
    let front_shiny: String
}

struct Moves: Codable {
    let move: Move
    let version_group_details: [VersionGroupDetails]
}

struct Move: Codable {
    let name: String
    let url: String
}

struct VersionGroupDetails: Codable {
    let level_learned_at: Int
    let move_learn_method: MoveLearnMethod
}

struct MoveLearnMethod: Codable {
    let name: String
    let url: String
}

