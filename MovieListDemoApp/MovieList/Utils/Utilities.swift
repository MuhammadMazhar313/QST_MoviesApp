//
//  Utilities.swift
//  MovieListDemoApp
//
//  Created by mac on 18/09/2023.
//

import Foundation



class Utilities {
    
    class func getCustomImagePath(name: String) -> String {
        let imagePathPrefix = "iv_"
        if name.split(separator: " ").count > 1 {
            return String( imagePathPrefix + (name.lowercased().split(separator: " ").last ?? ""))
        }else{
            return String( imagePathPrefix + name.lowercased())
        }
    }
    
}
