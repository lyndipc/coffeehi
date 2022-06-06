//
//  ThemeButtonLabel.swift
//  coffeehi
//
//  Created by Lyndi Castrejon on 6/4/22.
//

import SwiftUI

struct ThemeButtonLabel: View {
    
    var buttonText: String
    var width: CGFloat
    var height: CGFloat?
    var tracking: CGFloat?
    
    var body: some View {
        
        ZStack {
            
            Rectangle()
                .fill(Color.kellyGreen)
                .frame(width: width, height: height ?? 44)
                .cornerRadius(20)
            
            Text(buttonText)
                .bold()
                .foregroundColor(.white)
                .tracking(tracking ?? 3)
        }
    }
}

struct ThemeButtonLabel_Previews: PreviewProvider {
    
    static var previews: some View {
        
        GeometryReader { g in
         
            ThemeButtonLabel(buttonText: "Button Text", width: g.size.width - 80)
        }
    }
}
