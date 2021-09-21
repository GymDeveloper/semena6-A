//
//  ViewController.swift
//  semana6
//
//  Created by Linder Hassinger on 21/09/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var characterViewModel = CharacterViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        bind()
        setUpTable()
    }
    
    func configure() {
        characterViewModel.getCharacters()
    }
    
    func setUpTable() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isEditing = true
        navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func bind() {
        characterViewModel.refreshData = { [weak self] () in
            DispatchQueue.main.async {
                self?.printData()
                // aca se va a recargar la data del tableview
                self?.tableView.reloadData()
            }
        }
    }
    
    func printData() {
        for character in characterViewModel.arrayCharacters {
            print(character.name)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characterViewModel.arrayCharacters.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        
        let object = characterViewModel.arrayCharacters[indexPath.row]
      
        cell.textLabel?.text = object.name
        cell.detailTextLabel?.text = object.species
        
        // hemos convertido la foto a un dato
        let urlImage = URL(string: object.image)
        // parseamos la url a un Data
        let data = try? Data(contentsOf: urlImage!)
        
        // esto como convertir una foto a base64
        if let imageData = data {
            // pintamos la imagen en base a un data
            cell.imageView?.image = UIImage(data: imageData)
        }
        
        return cell
    }
    
    // reemplazo de editing
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            print(indexPath.row)
        }
        
    }
    
    // reemplazo de moveRowAt
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        print("movimiento")
    }
    

}

