//
//  UICollectioViewExtension.swift
//  ImageSearch
//
//  Created by Gio Lomsa on 9/20/19.
//  Copyright © 2019 Giorgi Lomsadze. All rights reserved.
//

import Foundation
import UIKit

extension SearchResultViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = imagesCollectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as? ImageCell{
            let currentImage = self.viewModel.images[indexPath.row]
            
            DispatchQueue.global(qos: .background).async {
                self.viewModel.loadImageFromUrl(urlString: currentImage.webformatURL, completion: {[weak cell] (imageDate) in
                    DispatchQueue.main.async {
                        cell?.imageView.image = UIImage(data: imageDate)
                    }
                })
            }
            return cell
        }else{
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.selectedImage = viewModel.images[indexPath.row]
        
        performSegue(withIdentifier: "ImageDetailsSegue", sender: self)
    }
    
}
