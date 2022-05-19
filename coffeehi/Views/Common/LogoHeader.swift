//
//  LogoHeader.swift
//  coffeehi
//
//  Created by Lyndi Castrejon on 5/19/22.
//

import SwiftUI

struct LogoHeader: View {
    
    var body: some View {
        
        Image("logo")
            .resizable()
            .scaledToFit()
            .frame(height: 25)
            .padding(.top)
            .padding(.bottom, 5.0)
            .shadow(color: Color(lightGray), radius: 0.8, x: 5.0, y: 3.0)
    }
}

struct LogoHeader_Previews: PreviewProvider {
    static var previews: some View {
        LogoHeader()
    }
}
