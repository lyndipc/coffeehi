//
//  NavBar.swift
//  coffeehi
//
//  Created by Lyndi Castrejon on 5/17/22.
//

import SwiftUI

struct NavBar: View {
    
    var body: some View {
        
        GeometryReader { g in
                
            HStack(spacing: 45.0) {
                
                Image("house")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 25)
                    .padding(.leading, 5.0)
                
                Image("arrow-trend")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 25)
                
                Image("square-plus")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 25)
                
                Image("bell")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 25)
                
                // TODO: Profile pic
                Circle()
                    .fill(.gray)
                    .frame(width: 35)
                    .padding(.trailing, 5.0)
                

            }
            .frame(width: g.size.width, height: 75)
        }
        .background(.white)
        .frame(height: 75)
    }
}

struct NavBar_Previews: PreviewProvider {
    static var previews: some View {
        NavBar()
    }
}
