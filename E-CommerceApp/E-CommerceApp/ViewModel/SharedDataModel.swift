//
//  SharedDataModel.swift
//  E-CommerceApp
//
//  Created by Ahmed Fathi on 28/11/2023.
//

import SwiftUI

class SharedDataModel: ObservableObject {

    //Detail product data
    
    @Published var detailProduct:Product?
    @Published var showDetailProduct:Bool = false
    
    // Matched Geometry effect for search view...
    @Published var fromSearchPage: Bool = false
    
    // Liked Products...
    @Published var likedProducts: [Product] = []
    
    // basket Products
    
    @Published var cartProducts: [Product] = []
    
}

