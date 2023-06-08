//
//  ViewController.swift
//  TheCatsApp
//
//  Created by Marcela Avila Beltran on 8/06/23.
//

import UIKit

class TheCatsViewController: UIViewController {

    @IBOutlet weak var ListCatsTableView: UITableView!
    var listCat: [Cat.infoCat]?
    let catAPIService = CatAPIService()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        ListCatsTableView.delegate = self
        ListCatsTableView.dataSource = self
        ListCatsTableView.register(UINib(nibName: "DetailViewController", bundle: nil), forCellReuseIdentifier: "DetailViewController")
        catAPIService.fetchBreeds { [weak self] list, error in
            if let error = error {
                // Manejar el error, por ejemplo, mostrar una alerta o registrar el error
                print("Error fetching breeds:", error.localizedDescription)
                return
            }
            
            // Actualizar la interfaz de usuario en el hilo principal
            DispatchQueue.main.async {
                // Asignar los datos obtenidos a la propiedad de datos del controlador
                self?.listCat = list
                
                // Actualizar la tabla o cualquier otro elemento de la interfaz de usuario con los datos
                self?.ListCatsTableView.reloadData()
            }
        }
    }



}

// MARK: UITableViewDelegate, UITableViewDataSource methods
extension TheCatsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listCat?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailViewController", for: indexPath) as! DetailViewController
        cell.nameBread = listCat?[indexPath.row].breadName
        cell.imageCatID = listCat?[indexPath.row].referenceImageId
        cell.originCat = listCat?[indexPath.row].origin
        cell.intelligenceCat = listCat?[indexPath.row].intelligence
        cell.affectionLevel = listCat?[indexPath.row].affectionLevel
        cell.setData()
        return cell
    }
    
}
