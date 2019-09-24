//
//  SearchResultViewController.swift
//  ImageSearch
//
//  Created by Gio Lomsa on 9/19/19.
//  Copyright © 2019 Giorgi Lomsadze. All rights reserved.
//

import UIKit

class SearchResultViewController: UIViewController {
    
    //MARK:- IBOutlets
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    @IBOutlet weak var noResultLabel: UILabel!
    
    //MARK:- Local Variables/Constants
    var keyword: String?
    var count: Int?
    var selectedImage: Image?
    let viewModel = SearchResultViewModel()

    //MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        noResultLabel.isHidden = true
        activityIndicator.startAnimating()
        
        imagesCollectionView.delegate = self
        imagesCollectionView.dataSource = self
        
        manageObservers()
        
        if let keyword = self.keyword,
            let count = count{
                DispatchQueue.global(qos: .background).async {
                    self.viewModel.loadSearchResults(keyword: keyword, count: count)
            }
        }
    }
    
    //MARK:- Class methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ImageDetailsViewController,
            let image = selectedImage{
            destination.selectedImage = image
        }
    }
    
    private func manageObservers(){
        NotificationCenter.default.addObserver(self, selector: #selector(updateUIFromViewModel) , name: SearchResultViewModel.imagesWereSetNotification, object: nil)
    }
    
    @objc private func updateUIFromViewModel(){
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            
            if self.viewModel.images.count > 0 {
                self.imagesCollectionView.reloadData()
            }else{
                self.noResultLabel.isHidden = false
            }
            
        }
    }
}
