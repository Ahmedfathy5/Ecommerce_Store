//
//  OnBoardingView.swift
//  E-CommerceApp
//
//  Created by Ahmed Fathi on 09/10/2023.
//

import SwiftUI

struct OnBoardingView: View {
   @State var customFont = "TEXAT BOLD PERSONAL USE___.otf"
    @State var showLoginPage: Bool = false
    var body: some View {
        VStack (alignment: .leading){
            Text("Find your\nGadget")
                .font(.custom(customFont, size: 55))
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding()
            Image("intro")
                .resizable()
             //   .scaledToFit()
                .shadow(color: Color("purple"), radius: 10, x: 10, y: 10)
            Button {
                withAnimation {
                    showLoginPage.toggle()
                }
            } label: {
                Text("Get started")
                    .font(.custom(customFont, size: 18))
                    .padding(.vertical , 18)
                    .frame(maxWidth: .infinity)
                    .background(.white)
                    .cornerRadius(15)
                    .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
                    .foregroundColor(Color("purple"))
            }
            .padding(.horizontal , 30)
            
            Spacer()

            
        }
      
        .frame(maxWidth: .infinity , maxHeight: .infinity)
        .background(Color("purple"))
        .overlay {
            if showLoginPage {
                loginPage()
                    .transition(.move(edge: .bottom))
            }
        }
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
        
            
    }
}
