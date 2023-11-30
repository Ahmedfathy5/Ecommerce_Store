//
//  ProfilePage.swift
//  E-CommerceApp
//
//  Created by Ahmed Fathi on 31/10/2023.
//

import SwiftUI

struct ProfilePage: View {
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 15.0) {
                    Image("download")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                    //.offset(y: -30)
                    //.padding(.bottom , -30)
                    Text("My Sister Vinny")
                        .font(.title2.weight(.semibold))
                    HStack(alignment: .top, spacing: 10) {
                        Image(systemName: "location.north.circle.fill")
                            .foregroundColor(.gray)
                            .rotationEffect(.init(degrees: 180))
                        
                        Text("Adderss: Meet anter\nElsook\nEgypt ")
                            .font(.caption)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    
                    
                }
                
                customNavigatioLink(title: "Edit Profile") {
                    Text("")
                        .navigationTitle("Edit Profile")
                        .frame(maxWidth: .infinity , maxHeight: .infinity)
                        .background(Color("HomeBG").ignoresSafeArea())
                }
                
                customNavigatioLink(title: "Shopping Address") {
                    Text("")
                        .navigationTitle("Shopping Address")
                        .frame(maxWidth: .infinity , maxHeight: .infinity)
                        .background(Color("HomeBG").ignoresSafeArea())
                }
                
                customNavigatioLink(title: "Order History") {
                    Text("")
                        .navigationTitle("Order History")
                        .frame(maxWidth: .infinity , maxHeight: .infinity)
                        .background(Color("HomeBG").ignoresSafeArea())
                }
                
                customNavigatioLink(title: "Cards") {
                    Text("")
                        .navigationTitle("Cards")
                        .frame(maxWidth: .infinity , maxHeight: .infinity)
                        .background(Color("HomeBG").ignoresSafeArea())
                }
                
                customNavigatioLink(title: "Notifications") {
                    Text("")
                        .navigationTitle("Notifications")
                        .frame(maxWidth: .infinity , maxHeight: .infinity)
                        .background(Color("HomeBG").ignoresSafeArea())
                }
                
                
            }.navigationTitle("My Profile")
        }
    }
    // Avoiding new Structs ...
    @ViewBuilder
    func customNavigatioLink<Detail: View>(title: String , @ViewBuilder content: @escaping()-> Detail ) -> some View {
        NavigationLink {
            content()
        } label: {
            HStack {
                
                Text(title)
                    .font(.footnote)
                    .fontWeight(.semibold)
                Spacer()
                
                Image(systemName: "chevron.right")
                
            }
            .foregroundColor(.black)
            .padding()
            .background(Color.white.cornerRadius(12))
            .padding(.horizontal)
            .padding(.top , 10)
            
        }
        
    }
}

struct ProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePage()
    }
}
