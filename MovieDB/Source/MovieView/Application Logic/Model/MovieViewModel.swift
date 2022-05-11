//
//  MovieViewModel.swift
//  MovieDB
//
//  Created by Neha2 Mishra on 09/05/22.
//

import Foundation
class MovieViewModel : Codable {
    var imageUrl: String?
    var title: String?
    
    enum CodingKeys: String, CodingKey {
        case imageUrl = "backdrop_path"
        case title
    }
    
}
