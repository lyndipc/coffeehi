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
            
            VStack {
                
                HStack(alignment: .bottom, spacing: 10.0) {
                    
                    Spacer()
                    
                    Image("Logo")
                        .padding([.leading, .bottom], 5.0)
                    
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
                    Circle()
                        .fill(.gray)
                        .frame(width: 35)
                        .padding(.trailing, 10.0)
                    
                    Spacer()

                }
                .frame(width: g.size.width, height: 55)
                
                Divider()
                    .background(Color.gray)
            }
        }
    }
}

struct NavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBar()
    }
}
