//
//  DetailViewController.swift
//  TheCatsApp
//
//  Created by Marcela Avila Beltran on 8/06/23.
//

import UIKit

class DetailViewController: UITableViewCell {
    
    @IBOutlet weak var nameBreedLabel: UILabel!
    @IBOutlet weak var imageCats: UIImageView!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var intelligenceLabel: UILabel!
    @IBOutlet weak var affectionLevelLabel: UILabel!
    @IBOutlet weak var catInfoView: UIView!
    
    var nameBread: String?
    var imageCatID: String?
    var originCat: String?
    var intelligenceCat: Int?
    var affectionLevel: Int?
    
    let catAPIService = CatAPIService()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setData(){
        catInfoView.layer.cornerRadius = 3.0
        catInfoView.layer.borderWidth = 1.0
        catInfoView.layer.borderColor = UIColor.gray.cgColor
        catAPIService.fetchCatImage(withReferenceID: imageCatID ?? "") { imageURL, error in
            if let error = error {
                // Manejar el error en caso de que no se pueda hacer el consumo
                print("Error fetching cat image:", error.localizedDescription)
                return
            }
            
            if let imageURL = imageURL, let url = URL(string: imageURL) {
                // Cargar y mostrar la imagen utilizando la URL obtenida
                DispatchQueue.global().async {
                    if let imageData = try? Data(contentsOf: url) {
                        let image = UIImage(data: imageData)
                        
                        DispatchQueue.main.async {
                            // Realizar asignacion en el UIImageView
                            self.imageCats.image = image
                        }
                    }
                }
            } else {
                // Manejar el caso en el que no se haya encontrado la URL de la imagen
                print("No se encontro imagen")
            }
        }
        nameBreedLabel.text = "Nombre Raza: \(nameBread ?? "No aplica")"
        originLabel.text = "Pais de origen: \(originCat ?? "No aplica")"
        intelligenceLabel.text = "Inteligencia: \(intelligenceCat ?? 0)"
        affectionLevelLabel.text = "Nivel de afecto: \(affectionLevel ?? 0)"
    }
    
}
