//
//  SearchNiew.swift
//  E-CommerceApp
//
//  Created by Ahmed Fathi on 14/10/2023.
//

import SwiftUI

struct SearchView: View {
    var animation : Namespace.ID
    
    @EnvironmentObject var homeData :HomeViewModel
    
    @EnvironmentObject var shareData : SharedDataModel
    
    @FocusState var startTF:Bool
    var body: some View {
        VStack(spacing:0) {
            HStack( spacing: 20) {
                Button {
                    withAnimation(.easeInOut) {
                        homeData.searchActivated.toggle()
                    }
                    homeData.searchText = ""
                    // resestting...
                    shareData.fromSearchPage = false
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.title2 )
                        .foregroundColor(.black.opacity(0.7))
                    
                }
                
                HStack(spacing: 15) {
                    Image(systemName: "magnifyingglass")
                        .font(.title2)
                        .foregroundColor(.gray)
                    TextField("Search", text: $homeData.searchText)
                        .focused($startTF)
                        .textCase(.lowercase)
                        .autocorrectionDisabled(true)
                }
                .padding(.vertical , 12)
                .padding(.horizontal )
                .background(
                    Capsule()
                        .strokeBorder(Color("purple"), lineWidth: 1.5)
                )
              .matchedGeometryEffect(id: "SEARCHBAR", in: animation)
                .padding(.trailing , 20)
                
                
            }
            .padding([.horizontal ])
            .padding(.top)
            
            if let products = homeData.searchProducts {
                if products.isEmpty  {
                    //MARK: - No results found
                    VStack(spacing: 10) {
                        Image("NotFound")
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(15)
                            .padding(.top , 60)
                        Text("Item Not Found")
                            .font(.title.bold())
                        Text("Try to be more generic search term ")
                            .font(.title)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal , 30 )
                     }
                    .padding()
                     
                } else {
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack( spacing: 0) {
                                 Text("Found \(products.count) results.")
                                .font(.title.bold())
                                .padding()
                            StaggeredGrid(coulmns: 2, list: products) { product in
                                productcardView(product: product)
                            }
                        }
                    }
                }
                
            } else {
                ProgressView()
                    .padding(.top , 30)
                    .opacity(homeData.searchText == "" ? 0 : 0)
                
            }
                
        
            
        }
        .frame(maxWidth: .infinity , maxHeight: .infinity , alignment: .top)
        .background(
            Color("HomeBg")
                .ignoresSafeArea()
        )
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1 ) {
                startTF = true
            }
        }
    }
    @ViewBuilder
    func productcardView (product: Product)-> some View  {
        VStack(spacing:10  ) {
            ZStack {
                if shareData.showDetailProduct {
                    Image(product.productImage)
                        .resizable()
                        .scaledToFit()
                        .opacity(0)
                } else {
                    Image(product.productImage)
                        .resizable()
                        .scaledToFit()
                        .matchedGeometryEffect(id: "\(product.id)SEARCH", in: animation)
                }
            }
                .frame(width: getRect().width / 2.5, height: getRect().width / 2.5)
                .offset(y: -80)
                .padding(.bottom , -80)
            Text(product.title)
                .font(.title2)
                .fontWeight(.semibold)
            Text(product.subtitle)
                .font(.body)
                .foregroundColor(.gray)
            Text(product.price)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(Color("purple"))
        }
        .padding(.horizontal , 25)
        .padding(.bottom , 22)
        .background(Color.white
            .cornerRadius(25)
        )
               .padding(.top , 80)
               .onTapGesture {
                   withAnimation(.easeInOut) {
                       shareData.fromSearchPage = true
                       shareData.detailProduct = product
                       shareData.showDetailProduct = true
                   }
               }
    }
    
    struct SearchNiew_Previews: PreviewProvider {
        static var previews: some View {
         MainPage()
        }
    }
}
