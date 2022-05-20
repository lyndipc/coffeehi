//
//  EngagementBar.swift
//  coffeehi
//
//  Created by Lyndi Castrejon on 5/17/22.
//

import SwiftUI

struct EngagementBar: View {
    var body: some View {
        
        HStack(spacing: 25.0) {
        
            HStack(spacing: 10.0) {
            
                Image("heart-solid")
                Text("12")
                    .foregroundColor(Color(primaryColor))
            }
            
            HStack(spacing: 10.0) {
             
                Image("message")
                Text("4")
                    .foregroundColor(Color(primaryColor))
            }
        }
    }
}

struct EngagementBar_Previews: PreviewProvider {
    static var previews: some View {
        EngagementBar()
    }
}
