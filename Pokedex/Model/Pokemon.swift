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

//var testPokemon = Pokemon(name: "test", url: "test.com")
//var testResults = Results(count: 1, next: "none.com", results: [testPokemon])
//var testForms = Forms(name: "test name", url: "test.com")
//var testSinglePokemon = SinglePokemon(id: 1, height: 1, base_experience: 1, forms: [testForms], sprites: testSprites, moves: [testMoves])
//var testSprites = Sprites(front_default: "", front_shiny: "")
//var testMoveLearnMethod = MoveLearnMethod(name: "", url: "")
//var testVersionGroupDetails = VersionGroupDetails(level_learned_at: 1, move_learn_method: testMoveLearnMethod)
//var testMove = Move(name: "", url: "")
//var testMoves = Moves(move: testMove, version_group_details: [testVersionGroupDetails])

