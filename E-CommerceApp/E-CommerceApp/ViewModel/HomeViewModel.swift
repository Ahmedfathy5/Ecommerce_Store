//
//  HomeViewModel.swift
//  E-CommerceApp
//
//  Created by Ahmed Fathi on 11/10/2023.
//

import SwiftUI



//MARK: - Using Combine to monitor search field and if user leaves 0.5 seconds then start search .....
// to avoid memory issue....
import Combine

class HomeViewModel: ObservableObject {
    @Published var productType:ProductType = .Wearable
    
    
    @Published var product: [Product] = [
        Product(type: .Wearable, title: "Apple Watch", subtitle: "Series 6 : red", price: "$359", productImage: "watch1"),
        Product(type: .Wearable, title: "Samsung Watch", subtitle: "Gear Black", price: "$180", productImage: "watch2"),
        Product(type: .Wearable, title: "Apple Watch", subtitle: "Series 4 : Black", price: "$250", productImage: "watch3"),
        Product(type: .Phones, title: "iPhone 13", subtitle: "A15 - Pink", price: "$699", productImage: "iPhone13"),
        Product(type: .Phones, title: "iPhone 12", subtitle: "A14 - Blue", price: "$599", productImage: "iPhone12"),
        Product(type: .Phones, title: "iPhone 11", subtitle: "A13 - Black", price: "$499", productImage: "iPhone11"),
        Product(type: .Phones, title: "iPhone SE", subtitle: "A12 - White", price: "$399", productImage: "iPhoneSE"),
        Product(type: .labtops, title: "MacBook Air", subtitle: "M1 - Gold", price: "1299", productImage: "MacBookAir"),
        Product(type: .labtops, title: "MacBook pro", subtitle: "M1 - Gray", price: "1499", productImage: "MacBookPro"),
        Product(type: .Tablets, title: "iPad Pro", subtitle: "M1 - Silver", price: "899", productImage: "iPadPro"),
        Product(type: .Tablets, title: "iPad Air", subtitle: "M1 - Gold", price: "999", productImage: "iPadAir")
    
    ]
    @Published var showMoreProduct = false
    
    
    @Published var Filtred : [Product] = []
    
    
    @Published var searchText: String = ""
    
    @Published var searchActivated: Bool = false
    
    @Published var searchProducts: [Product]?
    
    
    var searchCancelable : AnyCancellable?
    
    
    
    init(){
        filterProductByType()
        searchCancelable = $searchText.removeDuplicates()
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink(receiveValue: { str in
                if str != "" {
                    self.filterProductBySearch()
                } else {
                    self.searchProducts = nil
                }
            })
    }
    func filterProductByType(){
        DispatchQueue.global(qos: .userInteractive).async {
            let results = self.product
            
                .lazy
                .filter { Product in
                    return Product.type == self.productType
                }
                .prefix(4)
            DispatchQueue.main.async {
                self.Filtred =  results.compactMap({ product in
                    return product
                })
            }
        }
    }
    
    func filterProductBySearch(){
        DispatchQueue.global(qos: .userInteractive).async {
            let results = self.product
            
                .lazy
                .filter { Product in
                    return Product.title.lowercased().contains(self.searchText.lowercased())
                }
               
            DispatchQueue.main.async {
                self.searchProducts =  results.compactMap({ product in
                    return product
                })
            }
        }
    }
}
