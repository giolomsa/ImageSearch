//
//  HTTPLayer.swift
//  ImageSearch
//
//  Created by Gio Lomsa on 9/19/19.
//  Copyright © 2019 Giorgi Lomsadze. All rights reserved.
//

import Foundation

class HTTPLayer{
    
    let baseURLString = "https://pixabay.com/api/?key=13686907-887794c05a9433180301c352c&"
    #warning("Move API key to secret file")

    let urlSession = URLSession.shared
    
    enum Endpoint{
        
        case search(String, Int)
        case downloadFromUrl(String)
        
        var path: String{
            
            switch self {
            case .search(let keyword, let count ):

                let encodedKeyword = keyword.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
                return "q=\(String(describing: encodedKeyword!))&per_page=\(count)"
                
            case .downloadFromUrl(let urlString):
                return urlString
            }
        }
    }
    
    func request(at endpoint: Endpoint, isImage: Bool, completion: @escaping (Data?, URLResponse?, Error?)-> Void){
        
        var urlString = ""
        
        if isImage{
            urlString = endpoint.path
        }else{
            urlString = baseURLString + endpoint.path
        }
//        print(urlString)
        guard let url = URL(string: urlString) else {return }
        
        let task = urlSession.dataTask(with: url) { (data, response, error) in
            completion(data, response, error)
        }
        task.resume()
    }
}
