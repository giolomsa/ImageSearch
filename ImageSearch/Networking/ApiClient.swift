//
//  ApiClient.swift
//  ImageSearch
//
//  Created by Gio Lomsa on 9/20/19.
//  Copyright © 2019 Giorgi Lomsadze. All rights reserved.
//

import Foundation

class APIClient{
    
    let httpLayer: HTTPLayer
    var defaultError: NSError = NSError(domain: "", code: 1, userInfo: nil)
    
    enum Result<Element>{
        case success(Element)
        case failure(NSError)
    }
    
    init(httpLayer: HTTPLayer){
        self.httpLayer = httpLayer
    }
    
    //load search results
    func getSearchResult(keyword: String, count: Int, completion: @escaping (Result<[Image]>)-> Void){
        
        self.httpLayer.request(at: .search(keyword, count), isImage: false) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode.isSuccessHTTPCode,
                let data = data
                else {
                    if let error = error{
                        completion(.failure(error as NSError))
                    }
                    return
            }
//            print(data)
            do{
                let decoder = JSONDecoder()
                let images = try decoder.decode(SearchResult.self, from: data)
                completion(.success(images.hits))
            }catch let error{
                completion(.failure(error as NSError))
            }
        }
    }
    
    
    func downloadImages(from url: String , completion: @escaping(Result<Data>)-> Void){
        
        self.httpLayer.request(at: .downloadFromUrl(url), isImage: true) { (data, response, error) in
            
            guard let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode.isSuccessHTTPCode,
                let imageData = data
                else {
                    if let error = error{
                        completion(.failure(error as NSError))
                    }
                    return
            }
            completion(.success(imageData))
        }
    }
}
