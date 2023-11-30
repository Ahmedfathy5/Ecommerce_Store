//
//  Product.swift
//  E-CommerceApp
//
//  Created by Ahmed Fathi on 11/10/2023.
//

import SwiftUI

struct Product:Identifiable,Hashable {
    var id = UUID().uuidString
    var type: ProductType
    var title : String
    var subtitle:String
    var description : String = ""
    var price: String
    var productImage : String
    var quantity: Int = 1
    
}

enum ProductType: String, CaseIterable {
    case Wearable = "Watches"
    case labtops = "labtops"
    case Phones = "Phones"
    case Tablets = "Tablets"
}
