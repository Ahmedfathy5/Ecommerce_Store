//
//  loginPage.swift
//  E-CommerceApp
//
//  Created by Ahmed Fathi on 09/10/2023.
//

import SwiftUI

struct loginPage: View {
    @StateObject var vm:loginPageModel = loginPageModel()
    @State var customFont = "TEXAT BOLD PERSONAL USE___.otf"
    var body: some View {
        VStack {
                Text("Welcome\nback")
                .foregroundColor(.white)
                    .font(.custom(customFont, size: 55))
                    .frame(maxWidth: .infinity , alignment: .leading)
                    .padding()
                    .frame(height: UIScreen.main.bounds.height / 4)
            ScrollView(.vertical, showsIndicators: false) {
                VStack( spacing: 15) {
                    Text(vm.registerUser ? "Register" : "Login")
                        .font(.title.bold())
                        .frame(maxWidth:.infinity,alignment: .leading)
                    CustomTextField(icon:  "envelope.badge.fill",title: "Email", hint: "ahmed@gmail.com", value: $vm.email, showPassword: .constant(false))
                        .padding(.top , 15)
                    CustomTextField(icon:  "lock",title: "Password", hint: "123456", value: $vm.password, showPassword: $vm.showPassword)
                        .padding(.top , 10)
                   
                    if vm.registerUser {
                        CustomTextField(icon:  "envelope.badge.fill",title: "Re-Enter Password", hint: "123456", value: $vm.re_enter_password, showPassword: $vm.showre_enter_Password)
                            .padding(.top , 30)
                    }
                    Button {
                        vm.forgetPassword()
                    } label: {
                        Text("Forgot Password ?")
                            .fontWeight(.semibold)
                            .foregroundColor(Color("purple"))
                    }
                    .padding(.top, 8)
                    .frame(maxWidth: .infinity , alignment: .leading)
                    
                    //Login Button...
                    Button {
                        if vm.registerUser {
                            vm.register()
                        }else {
                            vm.login()
                        }
                    } label: {
                        Text("Login")
                            
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity )
                            .padding(.vertical , 20)
                            .background(Color("purple"))
                            .foregroundColor(.white)
                            .cornerRadius(15)
                    }
                    .padding(.top , 25)
                    .padding(.horizontal)
                    
                    // Register User ..
                    
                    Button {
                        withAnimation {
                            vm.registerUser.toggle()
                        }
                    } label: {
                        Text(vm.registerUser ? "Back to Login" : "Create account ")
                            .fontWeight(.semibold)
                            .foregroundColor(Color("purple"))
                    }
                    .padding(.top, 8)
                }
                .padding(30)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.white)
            .clipShape(customCorners(corner: [.topLeft , .topRight], raduis: 25))
            .ignoresSafeArea()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("purple"))
        
        
        .onChange(of: vm.registerUser) { newValue in
            vm.email = ""
            vm.password = ""
            vm.re_enter_password = ""
            vm.showPassword = false
            vm.showre_enter_Password = false
        }
       
     
        
    }
   
}
@ViewBuilder  func CustomTextField(icon:String, title:String,hint:String,value:Binding<String> ,showPassword:Binding<Bool>)-> some View {
      VStack(alignment: .leading, spacing: 15) {
          Label {
              Text(title)
                  .font(.largeTitle)
          } icon: {
              Image(systemName:icon)
                 .resizable()
                 .scaledToFit()
                  .frame(width: 30, height: 30)
          }
          .foregroundColor(.black.opacity(0.8))
          if title.contains("Password") && !showPassword.wrappedValue{
              
          SecureField(hint, text: value).padding(.top,2)
          } else {
              TextField(hint, text: value).padding(.top,2)
          }
          Divider()
              .background(.black.opacity(0.4))
      }
      .overlay(alignment: .trailing) {
          if title.contains("Password") {
              Button {
                  showPassword.wrappedValue.toggle()
              } label: {
                  Text(showPassword.wrappedValue ? "Hide" : "show")
                      .font(.body.bold())
                      .foregroundColor(Color("purple"))
              }
              .offset(y: 20)
          }
      }
  }

struct loginPage_Previews: PreviewProvider {
    static var previews: some View {
        loginPage()
    }
}
