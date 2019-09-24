//
//  ViewController.swift
//  ImageSearch
//
//  Created by Gio Lomsa on 9/19/19.
//  Copyright © 2019 Giorgi Lomsadze. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    //MARK:- IBOutlets
    @IBOutlet weak var formBackgroundView: UIView!
    @IBOutlet weak var keywordTextField: UITextField!
    @IBOutlet weak var resultCountTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    //MARK:- Local Variables/Constants
    enum ImageSearchErrors:String{
        case invalidInput
        case notPrime
        case couldnotLoadImages
        
        var errorDescription:String{
            switch self {
                #warning ("need better error messages")
            case .invalidInput:
                return "Invalid result count. Please enter prime number"
            case .notPrime:
                return "Result count number is not a prime number."
            case .couldnotLoadImages:
                return "Network error has occurred."
            }
        }
    }
    
    //LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Search Image"
        self.customizeUI()
    }
    
    //MARK:- IBActions
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        
        if let enteredCount = resultCountTextField.text,
            let count = Int(enteredCount){
            if count.isPrimeNumber{
                // show search results
                performSegue(withIdentifier: "SearchResultViewControllerSegue", sender: self)
            }else{
                // show entered number isn't prime alert
                self.showWrongInputAlert(message: ImageSearchErrors.notPrime.errorDescription)
            }
        }else{
            // entered information is invalid
            self.showWrongInputAlert(message: ImageSearchErrors.invalidInput.errorDescription)
        }
    }
    
    //MARK:- Class Methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? SearchResultViewController,
            let count = resultCountTextField.text{
            destination.keyword = keywordTextField.text
            destination.count = Int(count)
        }
    }
    
    private func customizeUI(){
        self.formBackgroundView.layer.cornerRadius = Constants.formBackgroundViewCornerRadius
        self.searchButton.layer.cornerRadius = Constants.searchButtonCornerRadius
    }
    
    private func showWrongInputAlert(message: String){
        
        let errorAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        errorAlertController.addAction(okAction)
        
        self.present(errorAlertController, animated: true, completion: nil)
    }
    
    
}

