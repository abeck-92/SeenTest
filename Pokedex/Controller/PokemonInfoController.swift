//
//  Pokemon.swift
//  Pokedex
//
//  Created by Austin Beck on 5/12/23.
//

import UIKit

class PokemonInfoController: UIViewController {
    
    // MARK: - Properties
    
    var pokemon: SinglePokemon? {
        didSet {
            navigationItem.title = pokemon?.name.capitalized
            if let pokeName = pokemon?.name.capitalized {
                nameLabel.text = "Name: \(pokeName)"
            }
            typeLabel.text = "Type: \((pokemon?.types[0].type.name)!)"
            movesLabel.text = "Moves"
            
            if let imageString = pokemon?.sprites.front_default, let url = URL(string: imageString) {
                downloadImage(url: url, imageView: imageView)
            }
        }
    }
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.backgroundColor = .white
        iv.layer.cornerRadius = 10
        return iv
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "Pokemon Solid", size: 22)
        label.text = "1"
        return label
    }()
    
    let typeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "Pokemon Solid", size: 22)
        label.text = "1"
        return label
    }()
    
    let movesLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "Pokemon Solid", size: 24)
        label.text = "Moves"
        return label
    }()
    
    lazy var detailsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis =  .vertical
        stack.spacing = 20
        [self.nameLabel, self.typeLabel].forEach { stack.addArrangedSubview($0)}
        return stack
    }()
    
    lazy var movesHeaderView: UIView = {
        let view = UIView()
        view.addSubview(movesLabel)
        movesLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var movesStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10.0
        stack.backgroundColor = .white
        stack.layer.cornerRadius = 12
        guard var moves = pokemon?.moves else { return stack }
        if moves.count >= 3 {
            let threeMoves = pokemon?.moves[0...2]
            for i in 0...2 {
                let label = PaddingLabel()
                label.textColor = .black
                label.font = UIFont(name: "Pokemon Solid", size: 16)
                label.text = moves[i].move.name
                label.paddingLeft = 12
                label.paddingTop = 5
                label.paddingBottom = 5
                stack.addArrangedSubview(label)
            }
        } else {
            for i in 0...moves.count {
                let label = PaddingLabel()
                label.textColor = .black
                label.font = UIFont(name: "Pokemon Solid", size: 16)
                label.text = moves[i].move.name
                label.paddingLeft = 12
                label.paddingTop = 5
                label.paddingBottom = 5
                stack.addArrangedSubview(label)
            }
        }
        
        return stack
    }()
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewComponents()
    }
    
    // MARK: - Helper Functions
    
    func configureViewComponents() {
        view.backgroundColor = .mainPink()
        navigationController?.navigationBar.tintColor = .white
        
        view.addSubview(imageView)
        imageView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 44, paddingLeft: 25, paddingBottom: 0, paddingRight:25, width: 250, height: 250)
        
        view.addSubview(detailsStackView)
        detailsStackView.anchor(top: imageView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 44, paddingLeft: 25, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        view.addSubview(movesHeaderView)
        movesHeaderView.anchor(top: detailsStackView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 44, paddingLeft: 145, paddingBottom: 20, paddingRight: 0, width: 0, height: 0)

        
        view.addSubview(movesStackView)
        movesStackView.anchor(top: movesHeaderView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 44, paddingLeft: 50, paddingBottom: 0, paddingRight: 50, width: 200, height: 0)
    }
    
}
