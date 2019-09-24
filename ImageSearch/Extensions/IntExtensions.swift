//
//  IntExtensions.swift
//  ImageSearch
//
//  Created by Gio Lomsa on 9/19/19.
//  Copyright © 2019 Giorgi Lomsadze. All rights reserved.
//

import Foundation

extension Int{
    public var isPrimeNumber: Bool{
        
        var isPrime:Bool = true
        
        if(self == 2){
            return true
        }
        else if(self < 2){
            return false
        }
        else{
            for i in 2...self-1{
                if((self%i) == 0){
                    isPrime = false
                    break
                }
            }
        }
        return isPrime
    }
    
    public var isSuccessHTTPCode: Bool {
        return 200 <= self && self < 300
    }
}
