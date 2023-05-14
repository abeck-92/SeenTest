//
//  Pokemon.swift
//  Pokedex
//
//  Created by Austin Beck on 5/12/23.
//

import UIKit

class PokedexCell: UICollectionViewCell {
    
    // MARK: - Properties
        
    var pokemon: SinglePokemon? {
        didSet {
            nameLabel.text = pokemon?.name.capitalized

            if let id = pokemon?.id {
                idLabel.text = ("Pokedex # \(id)")
            }
            
            if let imageString = pokemon?.sprites.front_default, let url = URL(string: imageString) {
                downloadImage(url: url, imageView: imageView)
            }
        }
    }
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .mainPink()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "Pokemon Solid", size: 18)
        label.text = "Bulbasaur"
        return label
    }()
    
    let idLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "Pokemon Solid", size: 18)
        label.text = "1"
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 20.0
        stack.alignment = .fill
        stack.distribution = .equalSpacing
        [self.nameLabel, self.idLabel].forEach { stack.addArrangedSubview($0)}
        
        return stack
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViewComponents()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper Functions
    
    func configureViewComponents() {
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        
        addSubview(imageView)
                imageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        addSubview(stackView)
        stackView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 15, paddingLeft: 25, paddingBottom: 10, paddingRight: 25, width: 0, height: 20)
    }
    
}

