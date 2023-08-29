//
//  ExchangeRate.swift
//  ByteCoin
//
//  Created by Ayush Narwal on 01/07/23.
//

import Foundation

struct ExchangeRate : Codable {
    let asset_id_base : String
    let asset_id_quote : String
    var rate : Double
    
    var roundedRate : String{
        return String(format: "%.2f", rate)
    }
}
