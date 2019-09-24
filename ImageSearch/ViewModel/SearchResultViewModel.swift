//
//  SearchResultViewModel.swift
//  ImageSearch
//
//  Created by Gio Lomsa on 9/20/19.
//  Copyright © 2019 Giorgi Lomsadze. All rights reserved.
//

import Foundation
import UIKit

class SearchResultViewModel{

    static let imagesWereSetNotification = Notification.Name.init(rawValue: "gio.lomsa.imagesWereSet")
    
    let httpLayer = HTTPLayer()
    let networking: APIClient
    
    var images = [Image](){
        didSet{
            NotificationCenter.default.post(name: SearchResultViewModel.imagesWereSetNotification, object: nil)
        }
    }
    
    init(){
        networking = APIClient(httpLayer: httpLayer)
    }
    
    func loadSearchResults(keyword: String, count: Int){
        networking.getSearchResult(keyword: keyword, count: count){[weak self](result) in
                switch result{
                case .failure(let error):
                    print(error.localizedDescription)
                //TODO:- Show network error alert
                case .success(let images):
                    self?.images = images
                }
            }
    }
    
    func loadImageFromUrl(urlString: String, completion: @escaping (Data)-> Void){
        networking.downloadImages(from: urlString) {(result) in
            switch result{
            case .failure(let error):
                print(error.localizedDescription)
            //TODO:- Show network error alert
            case .success(let imageData):
                completion(imageData)
            }
        }
    }
}

