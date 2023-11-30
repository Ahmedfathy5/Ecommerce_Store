//
//  SwiftUIView.swift
//  E-CommerceApp
//
//  Created by Ahmed Fathi on 28/11/2023.
//

import SwiftUI

struct LikedPage: View {
 
    @StateObject var shareData = SharedDataModel()
    // Delete Option...
    @State var showDeleteOption: Bool = false
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack{
                    // checking if liked Product are Empty..
                    if !shareData.likedProducts.isEmpty {
                        Group {
                            Image("noLiked")
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(15)
                                .padding()
                                .padding(.top , 35)
                            Text("No Favorites yet")
                                .font(.title2.bold())
                            Text("Hit the like button on each product page to save favorite ones")
                                .font(.body)
                                .foregroundColor(.gray)
                                .padding(.horizontal)
                                .padding(.top, 10)
                                .multilineTextAlignment(.center)
                        }
                    } else {
                        // Displaying products...
                        VStack( spacing: 15) {
                            // For Desining...
                            ForEach(shareData.likedProducts) { product  in
                                HStack(spacing: 0) {
                                    if showDeleteOption {
                                        Button {
                                            deleteProduct(product: product)
                                        } label: {
                                            Image(systemName: "minus.circle.fill")
                                                .font(.title2)
                                                .foregroundColor(.red)
                                        }
                                        .padding(.trailing)
                                    } else {
                                        CardView(product: product)
                                    }
                                   
                                }
                              
                               
                            }
                        }
                        Divider()
                        .padding(.top, 25)
                        .padding(.horizontal)
                        
                    }
                }
            }
            
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("HomeBG").ignoresSafeArea())
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Favorites")
                        .font(.title.bold())
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        withAnimation {
                            showDeleteOption.toggle()
                        }
                    } label: {
                        Image(systemName: "trash")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                            .foregroundColor(Color("orange"))
                    }
                    .opacity(shareData.likedProducts.isEmpty ? 0 : 1)
                }
            }
        }
    }
    @ViewBuilder func CardView(product: Product)-> some View {
        HStack(spacing: 15) {
            Image(product.productImage)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            VStack(alignment: .leading, spacing: 8) {
                Text(product.title)
                    .font(.title2.bold())
                    .lineLimit(1)
                Text(product.subtitle)
                    .font(.body.bold())
                    .foregroundColor(Color("purple"))
                Text("Type: \(product.type.rawValue)")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 10)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    func deleteProduct(product:Product) {
        if let index = shareData.likedProducts.firstIndex(where: { currentProduct in
            return product.id == currentProduct.id
        }) {
          let _ =  withAnimation {
                // removing....
                shareData.likedProducts.remove(at: index)
            }
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        LikedPage()
            .environmentObject(HomeViewModel())
           
    }
}
