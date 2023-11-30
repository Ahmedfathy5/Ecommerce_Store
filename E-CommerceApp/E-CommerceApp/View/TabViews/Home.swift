//
//  Home.swift
//  E-CommerceApp
//
//  Created by Ahmed Fathi on 11/10/2023.
//

import SwiftUI

struct Home: View {
    var animation: Namespace.ID
    // share data
    @EnvironmentObject var shareData : SharedDataModel
    
    @StateObject var homeData: HomeViewModel = HomeViewModel()
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack( spacing: 15) {
                ZStack {
                    if homeData.searchActivated == true {
                         SearchBar()
                    } else {
                        SearchBar()
                            .matchedGeometryEffect(id: "SEARCHBAR", in: animation)
                    }
                }
                .frame(width: getRect().width / 1.6)
                .padding(.horizontal , 25)
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        homeData.searchActivated = true
                    }
                }
                Text("Oredr Online\nCollect in Store")
                    .font(.largeTitle.bold())
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .padding(.top)
                    .padding(.horizontal , 25)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack (spacing: 1 ){
                        ForEach(ProductType.allCases , id: \.self) { type in
                            productTypeView(type: type )
                        }
                    }
                }
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack (spacing: 25) {
                        ForEach(homeData.Filtred) { product in
                            productcardView(product: product)
                        }
                    }
                    .padding(.horizontal , 25)
                }
                .padding(.top , 30)
                Button {
                    homeData.showMoreProduct.toggle()
                } label: {
                    Label {
                        Image(systemName: "arrow.right")
                    } icon: {
                        Text("see more")
                    }
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color("purple"))
                    .frame(maxWidth: .infinity , alignment: .trailing)
                    .padding(.trailing)
                    .padding(.top , 30)
                }
            }
            .padding(.vertical)
        }
        .frame(maxWidth: .infinity , maxHeight: .infinity)
        .background(.regularMaterial)
        .onChange(of: homeData.productType) { newValue in
            homeData.filterProductByType()
        }
        .sheet(isPresented: $homeData.showMoreProduct) {
            MoreProductsView()
        }
        .overlay {
            ZStack {
                if homeData.searchActivated {
                    SearchView(animation: animation)
                        .environmentObject(homeData)
                }
            }
        }
    }
    @ViewBuilder func SearchBar ()-> some View {
        HStack(spacing: 15) {
            Image(systemName: "magnifyingglass")
                .font(.title2)
                .foregroundColor(.gray)
            TextField("Search", text: .constant(""))
                .disabled(true)
        }
        .padding(.vertical , 12)
        .padding(.horizontal )
        .background(
            Capsule()
                .strokeBorder(Color.gray, lineWidth: 0.8)
        )
    }
    @ViewBuilder func productcardView (product: Product)-> some View  {
        VStack(spacing:10  ) {
            // Adding matched Geometry effect...
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
                        .matchedGeometryEffect(id: "\(product.id)IMAGE", in: animation)
                    
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
        // showing product detail when tapped ...
               .onTapGesture {
                   withAnimation(.easeInOut) {
                       shareData.detailProduct = product
                       shareData.showDetailProduct = true
                   }
               }
    }
    @ViewBuilder func productTypeView (type: ProductType) -> some View{
        Button {
            withAnimation (.easeOut){
                homeData.productType = type
            }
        } label: {
            Text(type.rawValue)
                .fontWeight(.semibold)
                .foregroundColor(homeData.productType == type ? Color("purple") : .gray)
//                .background(
//                Capsule()
//                    .strokeBorder(.gray )
//                    .frame(width: 140)
//                )
                .overlay (
                    ZStack {
                        if homeData.productType == type {
                            Capsule()
                                .fill(Color("purple"))
                                .matchedGeometryEffect(id: "PRODUCTTAB", in: animation)
                                .frame(height: 5)
                                .padding(.top , 21)
                        } else {
                            Capsule()
                                .fill(.clear)
                                .frame(height: 5)
                        }
                    }
                        .padding(.horizontal , -5)
                )
        }
        .padding(.horizontal)

    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}
extension View {
    func getRect ()-> CGRect {
        return UIScreen.main.bounds
    }
}
