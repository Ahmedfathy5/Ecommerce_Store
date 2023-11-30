//
//  MainPage.swift
//  E-CommerceApp
//
//  Created by Ahmed Fathi on 11/10/2023.
//

import SwiftUI

struct MainPage: View {
    // Current Tab
    @State var selection : Tab = .Home
   
    @Namespace var animation
    @StateObject var shareData = SharedDataModel()
    
    var body: some View {
        VStack {
            TabView(selection: $selection) {
                Home(animation: animation)
                    .environmentObject(shareData)
                // adding transitions...
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .opacity))

                    .tabItem({
                        Image(systemName: Tab.Home.rawValue)
                        Text("Home")
                    })
                    .tag(Tab.Home)
               LikedPage()
                    .environmentObject(shareData)
                    .tabItem({
                        Image(systemName: Tab.Liked.rawValue)
                        Text("Liked")
                    })
                  .tag(Tab.Liked)
               
               CartPage()
                    .tabItem({
                        Image(systemName: Tab.Cart.rawValue)
                        Text("Cart")
                    })
                    .tag(Tab.Cart)
                
                ProfilePage()
                    .tabItem({
                        Image(systemName: Tab.Profile.rawValue)
                        Text("Profile")
                    })
                    .tag(Tab.Profile)
            }
            .accentColor(Color("purple"))
        }
        
        .overlay {
            ZStack {
                // Detail page ...
                if let product = shareData.detailProduct, shareData.showDetailProduct {
                    ProductDetailView(product: product, animation: _animation)
                        .environmentObject(shareData)
                }
            }
        }
    }
}

struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}

enum Tab: String,CaseIterable {
    case Home = "house.fill"
    case Liked = "heart.fill"
    case Profile = "person"
    case Cart = "cart.fill"
    
}
