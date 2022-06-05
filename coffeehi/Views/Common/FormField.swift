//
//  FormField.swift
//  coffeehi
//
//  Created by Lyndi Castrejon on 6/4/22.
//

import SwiftUI

struct FormField: View {
    
    @Binding var value: String
    var label: String
    var placeholder: String
    var width: CGFloat
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            Text(label)
                .foregroundColor(Color(primaryColor.cgColor))
                .tracking(3)
            
            ZStack {
                
                Rectangle()
                    .fill(Color(offWhite.cgColor))
                
                TextField(placeholder, text: $value)
                    .padding(.leading)
            }
            .frame(width: width, height: 44)
            .cornerRadius(10)
        }
    }
}

//struct FormField_Previews: PreviewProvider {
//    static var previews: some View {
//
//        var email = "whodis@gmail.com"
//
//        GeometryReader { g in
//
//            FormField(value: $email, label: "email", placeholder: "Email", width: g.size.width - 60)
//        }
//    }
//}
