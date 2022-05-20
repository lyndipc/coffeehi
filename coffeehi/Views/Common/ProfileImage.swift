//
//  ProfileImage.swift
//  coffeehi
//
//  Created by Lyndi Castrejon on 5/20/22.
//

import SwiftUI

struct ProfileImage: View {
    
    var width: CGFloat?
    var photo: String?
    
    var body: some View {
        
        Image(photo ?? "")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: width, height: width)
            .clipShape(Circle())
            .padding([.leading, .trailing], 10.0)
    }
}

struct ProfileImage_Previews: PreviewProvider {
    static var previews: some View { 
        ProfileImage(width: 50, photo: "ben")
    }
}
