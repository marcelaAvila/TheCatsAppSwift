//
//  Cat.swift
//  TheCatsApp
//
//  Created by Marcela Avila Beltran on 8/06/23.
//

import Foundation

enum Cat {
    struct infoCat: Codable {
        let breadName: String?
        let origin: String?
        let affectionLevel: Int?
        let intelligence: Int?
        let referenceImageId: String?
        
        private enum CodingKeys: String, CodingKey {
            case breadName = "name"
            case origin
            case affectionLevel = "affection_level"
            case intelligence
            case referenceImageId = "reference_image_id"
        }
    }
}
