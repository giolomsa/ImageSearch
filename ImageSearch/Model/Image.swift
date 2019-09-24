//
//  Image.swift
//  ImageSearch
//
//  Created by Gio Lomsa on 9/20/19.
//  Copyright © 2019 Giorgi Lomsadze. All rights reserved.
//

import Foundation

class Image: Codable{
    var largeImageURL: String
    var webformatURL: String
}

struct SearchResult: Codable{
    var hits: [Image]
}
