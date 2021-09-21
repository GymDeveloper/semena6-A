//
//  CharacterViewModel.swift
//  semana6
//
//  Created by Linder Hassinger on 21/09/21.
//

import Foundation

class CharacterViewModel {
    
    let urlAPI = "https://rickandmortyapi.com/api/character/"
    
    var refreshData = {
        () -> () in
    }
    
    var arrayCharacters : [Results] = [] {
        didSet {
            refreshData()
        }
    }
    
    func getCharacters() {
        guard let url = URL(string: urlAPI) else { return }
        
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            
            guard let dataJSON = data else { return }
            
            do {
                let decoder = JSONDecoder()
                
                // recordemos que character es el modelo padre el cual contiene a results
                let character = try decoder.decode(Character.self, from: dataJSON)
                
                // character.results contiene todo el data de results de api
                self.arrayCharacters = character.results
                
            } catch let error as NSError {
                print(String(describing: error))
            }
        }.resume()
    }
}
