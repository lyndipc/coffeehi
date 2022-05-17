//
//  NavigationBar.swift
//  coffeehi
//
//  Created by Lyndi Castrejon on 5/17/22.
//

import SwiftUI

struct NavigationBar: View {
    
    var body: some View {
        
        GeometryReader { g in
            HStack(alignment: .bottom, spacing: 10.0) {
                
                Image("Logo")
                    .padding(.leading)
                
                Spacer()
                
                HStack {
                    Text("Feed")
                    Text("Learn")
                    Text("Explore")
                }
                .foregroundColor(Color(primaryColor))
                .font(.body)
                
                Spacer()
                // Profile pic
            }
            .frame(width: g.size.width, height: 55)
        }
    }
}

struct NavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBar()
    }
}
