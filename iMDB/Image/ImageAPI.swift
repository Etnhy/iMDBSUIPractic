//
//  ImageAPI.swift
//  iMDB
//
//  Created by Evhenii Mahlena on 08.06.2022.
//

import UIKit
import Combine

class ImageAPI {
    static let shared   = ImageAPI()
    static let basePath = "https://image.tmdb.org/t/p/"
    
    enum Size: String {
        case small  = "w154"
        case medium = "w500"
        case large  = "w780"
        case original = "original"
        
        case cast   = "w185"
        
    func path(poster: String?) -> URL? {
        return (poster != nil && poster != "null")
        ? URL(string: (basePath + rawValue))!.appendingPathComponent(poster!)
        : nil
        }
    }
}
