//
//  TrendingView.swift
//  coffeehi
//
//  Created by Lyndi Castrejon on 5/19/22.
//

import SwiftUI

struct TrendingView: View {
    
    var body: some View {
        
        VStack {
            
            LogoHeader()
            
            Spacer()
            
            VStack {
                
                VStack(alignment: .leading) {
                    
                    VStack(alignment: .leading, spacing: 10.0) {
                        Text("Trending")
                            .bold()
                            .font(.title2)
                            .padding(.bottom)
                        
                        VStack(alignment: .leading, spacing: 8.0) {
                            Text("Modern French Press")
                            Text("Clean Coffee Setups")
                            Text("Show Off Your Mugs!")
                            Text("Latte Art")
                        }
                        .padding(.leading)
                        
                        Spacer()
                        
                        Text("Top Posts")
                            .bold()
                            .font(.title2)
                            .padding(.bottom)
                        
                        HStack {
                            Rectangle()
                                .fill(Color(lightGray))
                                .frame(width: 150, height: 150)
                                .cornerRadius(5)
                            
                            Rectangle()
                                .fill(Color(lightGray))
                                .frame(width: 150, height: 150)
                                .cornerRadius(5)
                        }
                        
                        HStack {
                            Rectangle()
                                .fill(Color(lightGray))
                                .frame(width: 150, height: 150)
                                .cornerRadius(5)
                            
                            Rectangle()
                                .fill(Color(lightGray))
                                .frame(width: 150, height: 150)
                                .cornerRadius(5)
                        }
                        
                        Spacer()
                    }
                }
                .padding(.top)
                .foregroundColor(Color(primaryColor))
            }
            .ignoresSafeArea(edges: [.bottom])
        }
    }
}

struct TrendingView_Previews: PreviewProvider {
    static var previews: some View {
        TrendingView()
    }
}
