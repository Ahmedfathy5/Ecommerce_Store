//
//  loginPageModel.swift
//  E-CommerceApp
//
//  Created by Ahmed Fathi on 09/10/2023.
//

import SwiftUI

class loginPageModel:  ObservableObject{
    @Published var email: String = ""
    @Published var password : String = ""
    @Published var showPassword: Bool = false
    
    @Published var registerUser: Bool = false
    @Published var re_enter_password: String = ""
    @Published var showre_enter_Password: Bool = false
    
    func login() {
        
    }
    func register () {
         
    }
    func forgetPassword (){
        
    }
}

