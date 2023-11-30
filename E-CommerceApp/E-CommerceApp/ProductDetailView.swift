//
//  ProductDetailView.swift
//  E-CommerceApp
//
//  Created by Ahmed Fathi on 28/11/2023.
//

import SwiftUI

struct ProductDetailView: View {
    var product: Product
    
    // For Matched Geometry effect...
    @Namespace var animation
    
    // shared data model
    @EnvironmentObject var sharedData : SharedDataModel
    
    @EnvironmentObject var homeData: HomeViewModel
    
    var body: some View {
        
        NavigationStack {
            VStack {
                
                // Title bar and product Image
                // Adding matced Geometry effect...
                VStack {
                    Image(product.productImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .matchedGeometryEffect(id: "\(product.id)\(sharedData.fromSearchPage ? "SEARCH" : "IMAGE" )", in: animation)
                        .padding(.horizontal)
                        .offset(y: -12)
                        .frame( maxHeight: .infinity)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            withAnimation(.easeInOut) {
                                sharedData.showDetailProduct = false
                            }
                        } label: {
                            Image(systemName: "arrow.left")
                                .font(.title2)
                        }

                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            addToLiked()
                        } label: {
                            Image(systemName: "heart.fill")
                                .renderingMode(.template)
                                .foregroundColor(isLiked() ? .red : .black)
                                
                        }

                    }
                }
                .frame(height: getRect().height / 2.7)
                .zIndex(1)
                // product details..
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 15) {
                        Text(product.title)
                            .font(.title.bold())
                        
                        Text(product.subtitle)
                            .font(.title)
                            .foregroundColor(.gray)
                        
                        Text("Get apple TV+ free for a year")
                            .font(.body.bold())
                            .padding(.top)
                        Text("Avalible when you purchase any mew iphone, ipad , ipod touch, Mac or Apple TV, $4.99/month after free trial.")
                            .font(.body)
                            .foregroundColor(.gray)
                        
                        Button {
                            
                            // since we need image at right
                        } label: {
                            Label {
                            Image(systemName: "arrow.right")
                            } icon: {
                                Text("Full description")
                            }
                            .font(.body.bold())
                            .foregroundColor(Color("purple"))
                        }

                        HStack {
                            Text("Total")
                                .font(.body)
                            Spacer()
                            Text("\(product.price)")
                                .font(.body.bold())
                                .foregroundColor(Color("purple"))
                        }
                        .padding(.vertical,20)
                        // Add button
                        Button {
                            addToCart()
                        } label: {
                            Text("\(isAddedToCart() ? "added" : "add") to basket")
                                .font(.footnote.bold())
                                .foregroundColor(.white)
                                .padding(.vertical,20)
                                .frame(maxWidth: .infinity)
                                .background(
                                    Color("purple")
                                        .cornerRadius(15)
                                        .shadow(color: Color.black.opacity(0.06), radius: 5, x: 5, y: 5 )
                                )
                        }

                        
                    }
                    .padding([.horizontal, .bottom] , 20)
                    .padding(.top,25)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.white
                    .clipShape(customCorners(corner: [.topLeft,.topRight], raduis: 25))
                    .ignoresSafeArea()
                )
                .zIndex(0)
                
              
            }
            .animation(.easeInOut, value: sharedData.likedProducts)
            .animation(.easeInOut, value: sharedData.cartProducts)
        }
    }
    func isLiked()->Bool {
        return sharedData.likedProducts.contains { product in
            return self.product.id == product.id
        }
    }
    
    func isAddedToCart()->Bool {
        return sharedData.cartProducts.contains { product in
            return self.product.id == product.id
        }
    }
    func addToLiked(){
        if let index = sharedData.likedProducts.firstIndex(where: { product in
            return self.product.id == product.id
        }) {
            // Remove all from like
            sharedData.likedProducts.remove(at: index)
        } else {
            sharedData.likedProducts.append(product)
        }
    }
    
    func addToCart(){
        if let index = sharedData.cartProducts.firstIndex(where: { product in
            return self.product.id == product.id
        }) {
            // Remove all from like
            sharedData.cartProducts.remove(at: index)
        } else {
            sharedData.cartProducts.append(product)
        }
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        
        // sample produc for Building Preview...
        ProductDetailView(product: HomeViewModel().product[0] )
            .environmentObject(SharedDataModel())
    }
}
