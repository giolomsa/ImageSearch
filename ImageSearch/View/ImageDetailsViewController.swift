//
//  ImageDetailsViewController.swift
//  ImageSearch
//
//  Created by Gio Lomsa on 9/20/19.
//  Copyright © 2019 Giorgi Lomsadze. All rights reserved.
//

import UIKit

class ImageDetailsViewController: UIViewController {

    //MARK:- IBOutlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //Local Variables/Constants
    let viewModel = SearchResultViewModel()
    var selectedImage: Image?
    
    //MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.startAnimating()
        loadImage()
    }
    
    //MARK:- Class methods
    private func loadImage(){
        if let image = selectedImage{
            DispatchQueue.global(qos: .background).async {
                self.viewModel.loadImageFromUrl(urlString: image.largeImageURL, completion: {[weak self] (imageData) in
                    DispatchQueue.main.async {
                        self?.imageView.image = UIImage(data: imageData)
                        self?.activityIndicator.stopAnimating()
                        self?.activityIndicator.isHidden = true
                    }
                })
            }
        }
    }

}
