//
//  NotificationView.swift
//  coffeehi
//
//  Created by Lyndi Castrejon on 5/23/22.
//

import SwiftUI

struct NotificationView: View {
    var body: some View {
        GeometryReader { g in
            
            VStack {
                
                Text("Notifications")
                    .padding([.top, .bottom])
                
                Divider()
                
                LazyVStack(alignment: .leading) {
                    
                    ForEach(0..<5) { _ in
                        HStack {
                            
                            ProfileImage(width: 35, photo: "zoe")
                            Text("Zoe Barnes liked your photo")
                            
                            Spacer()
                            
                            Image("heart-solid")
                                .padding(.trailing)
                        }
                        .padding([.top, .bottom], 10.0)
                        
                        Divider()
                    }
                }
                .padding([.leading, .trailing])
            }
        }
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
