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
        
        GeometryReader { g in
            
            VStack {
                
                VStack(alignment: .center, spacing: 40.0) {
                    
                    // Logo
                    HStack(spacing: 10.0) {
                        
                        Text("coffeehi")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .tracking(8)
                        Image("logo")
                    }
                    
                    Text("a place to share a cup of caffeinated magic with some friends")
                        .frame(width: g.size.width / 2)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                }
                .frame(width: g.size.width, height: g.size.height / 2.2)
            
            
                // Check for Login or Create Account Form
                if loginMode == Constants.LoginMode.login {
                    
                    LoginView(loginMode: $loginMode)
                }
                else {
                    
                    CreateAccountView(loginMode: $loginMode)
                }
            }
        }
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView()
    }
}
