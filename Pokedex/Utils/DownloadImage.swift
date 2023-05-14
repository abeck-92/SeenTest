//
//  Pokemon.swift
//  Pokedex
//
//  Created by Austin Beck on 5/12/23.
//

import Foundation
import UIKit

func downloadImage(url: URL, imageView: UIImageView) {
    URLSession.shared.dataTask(with: url) { (data, response, error) in
        if error != nil {
            print("\(String(describing: error?.localizedDescription))")
        }
        guard let imageData = data else { return }
        
        DispatchQueue.main.async {
            imageView.image = UIImage(data: imageData)
        }
    }.resume()
}
