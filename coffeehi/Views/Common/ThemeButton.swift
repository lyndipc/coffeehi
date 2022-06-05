//
//  ThemeButton.swift
//  coffeehi
//
//  Created by Lyndi Castrejon on 6/4/22.
//

import SwiftUI

struct ThemeButton: View {
    
    var buttonText: String
    var width: CGFloat
    
    var body: some View {
        
        // TODO: Add parameter to pass in button method/action
        ZStack {
            
            Rectangle()
                .fill(Color(primaryColor.cgColor))
                .frame(width: width, height: 44)
                .cornerRadius(20)
            
            Text(buttonText)
                .foregroundColor(.white)
                .tracking(3)
        }
    }
}

struct ThemeButton_Previews: PreviewProvider {
    
    static var previews: some View {
        
        GeometryReader { g in
         
            ThemeButton(buttonText: "Button Text", width: g.size.width - 80)
        }
    }
}
