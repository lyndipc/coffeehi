//
//  AuthenticationView.swift
//  coffeehi
//
//  Created by Lyndi Castrejon on 6/2/22.
//

import SwiftUI

struct AuthenticationView: View {
    
    @EnvironmentObject var model: ContentModel
    @State var loginMode = Constants.LoginMode.login
    
    var body: some View {
        
        // Check for Login or Create Account Form
        if loginMode == Constants.LoginMode.login {
            
            LoginView(loginMode: $loginMode)
        }
        else {
            
            CreateAccountView(loginMode: $loginMode)
        }
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView()
    }
}
