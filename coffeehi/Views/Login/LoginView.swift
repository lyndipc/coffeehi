//
//  LoginView.swift
//  coffeehi
//
//  Created by Lyndi Castrejon on 5/17/22.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        
        GeometryReader { g in
            
            VStack {
                
                VStack(alignment: .center, spacing: 40.0) {
                    
                    HStack(spacing: 10.0) {
                        
                        Text("coffeehi")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .tracking(5)
                        Image("Logo")
                    }
                    
                    Text("a place to share a cup of caffeinated magic with some friends")
                        .tracking(2)
                        .frame(width: g.size.width / 2)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                }
                .frame(width: g.size.width, height: g.size.height / 2.2)
                
                VStack(spacing: 40.0) {
                    
                    VStack(alignment: .leading) {
                        
                        Text("username")
                            .foregroundColor(Color(UIColor(red: 0.016, green: 0.767, blue: 0.541, alpha: 1).cgColor))
                            .tracking(2.5)
//                            .font(.headline)
                        
                        ZStack {
                            
                            Rectangle()
                                .fill(Color(UIColor(red: 229, green: 229, blue: 229, alpha: 0.5)))
                                .frame(width: g.size.width - 60, height: 44)
                                .cornerRadius(10)
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        
                        Text("password")
                            .foregroundColor(Color(UIColor(red: 0.016, green: 0.767, blue: 0.541, alpha: 1).cgColor))
                            .tracking(2.5)
                        
                        ZStack {
                            
                            Rectangle()
                                .fill(Color(UIColor(red: 229, green: 229, blue: 229, alpha: 0.5)))
                                .frame(width: g.size.width - 60, height: 44)
                                .cornerRadius(10)
                        }
                        Text("Forgot password?")
                            .foregroundColor(Color(UIColor(red: 0.016, green: 0.767, blue: 0.541, alpha: 1).cgColor))
                            .underline()
                            .font(.caption)
                            .tracking(1)
                    }
                    
                    ZStack {
                        
                        Rectangle()
                            .fill(Color(UIColor(red: 0.016, green: 0.767, blue: 0.541, alpha: 1).cgColor))
                            .frame(width: g.size.width - 80, height: 44)
                            .cornerRadius(20)
                        
                        Text("sign in")
                            .foregroundColor(.white)
                            .tracking(2.5)
                    }
                    
                    Text("Create an account")
                        .foregroundColor(Color(UIColor(red: 0.016, green: 0.767, blue: 0.541, alpha: 1).cgColor))
                        .underline()
                        .font(.headline)
                        .tracking(2)
                }
            }
        }
        .background(Color(UIColor(red: 0, green: 0, blue: 0, alpha: 0.68)))

    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
