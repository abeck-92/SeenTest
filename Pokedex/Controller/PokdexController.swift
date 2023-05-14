//
//  Pokemon.swift
//  Pokedex
//
//  Created by Austin Beck on 5/12/23.
//

import UIKit

private let reuseIdentifier = "PokedexCell"

class PokedexController: UICollectionViewController {
    
    // MARK: - Properties
    
    var pokemon = [SinglePokemon]()
    var filteredPokemon = [SinglePokemon]()
    var inSearchMode = false
    var searchBar: UISearchBar!
    
    let loadingView: UIImageView = {
        let pokeballImage = UIImage(named: "pokeball")
        let iv = UIImageView()
        iv.image = pokeballImage
        iv.frame.size.width = 200
        iv.frame.size.height = 200
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .mainPink()
        return iv
    }()
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewComponents()
        fetchPokemon()
        collectionView.reloadData()
        collectionView.backgroundColor = .mainPink()
    }
    
    // MARK: - Selectors
    
    @objc func showSearchBar() {
        configureSearchBar(shouldShow: true)
    }
    
    // MARK: - API
    
    func fetchPokemon() {
        showActivityIndicator()
        
        Service.shared.fetchPokemon { (pokemon) in
            DispatchQueue.main.async {
                let results = [pokemon] as! [Results]
                for result in results[0].results {
                    Service.shared.getSinglePokemon(url: result.url) { (pokemon) in
                        self.getPokemonDetails(url: result.url)
                    }
                }
            }
        }
    }
    
    func getPokemonDetails(url: String) {
        Service.shared.getSinglePokemon(url: url) { (pokemon) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                guard let pokemon = pokemon as? SinglePokemon else {
                    return
                }
                self.pokemon.append(pokemon)
                self.hideActivityIndicator()
            }
            self.collectionView.reloadData()
        }
    }
    
    // MARK: - Helper Functions
    
    func showPokemonInfoController(withPokemon pokemon: SinglePokemon) {
        let controller = PokemonInfoController()
        controller.pokemon = pokemon
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func showActivityIndicator() {
        loadingView.center = self.view.center
        self.view.addSubview(loadingView)
        loadingView.rotate()
    }

    func hideActivityIndicator() {
        loadingView.isHidden = true
        collectionView.backgroundColor = .white
    }
    
    func configureSearchBar(shouldShow: Bool) {
        
        if shouldShow {
            searchBar = UISearchBar()
            searchBar.delegate = self
            searchBar.sizeToFit()
            searchBar.showsCancelButton = true
            searchBar.becomeFirstResponder()
            searchBar.tintColor = .white
            
            navigationItem.rightBarButtonItem = nil
            navigationItem.titleView = searchBar
        } else {
            navigationItem.titleView = nil
            configureSearchBarButton()
            inSearchMode = false
            collectionView.reloadData()
        }
    }
    
    func configureSearchBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(showSearchBar))
        navigationItem.rightBarButtonItem?.tintColor = .white
    }
    
    func configureViewComponents() {
        collectionView.backgroundColor = .white
        
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isTranslucent = false
        
        navigationItem.title = "Pokedex"
        
        configureSearchBarButton()
        
        collectionView.register(PokedexCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
}

// MARK: - UISearchBarDelegate

extension PokedexController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        configureSearchBar(shouldShow: false)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText == "" || searchBar.text == nil {
            inSearchMode = false
            collectionView.reloadData()
            view.endEditing(true)
        } else {
            inSearchMode = true
            filteredPokemon = pokemon.filter({ $0.name.range(of: searchText.lowercased()) != nil })
            collectionView.reloadData()
        }
    }
}

// MARK: - UICollectionViewDataSource/Delegate

extension PokedexController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return inSearchMode ? filteredPokemon.count : pokemon.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PokedexCell
        
        cell.pokemon = inSearchMode ? filteredPokemon[indexPath.row] : pokemon[indexPath.row]
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pokemon = inSearchMode ? filteredPokemon[indexPath.row] : pokemon[indexPath.row]
        
        showPokemonInfoController(withPokemon: pokemon)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PokedexController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 32, left: 8, bottom: 8, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.height / 4)
        let width = (view.frame.width - 36)
        return CGSize(width: width, height: height)
    }
}

