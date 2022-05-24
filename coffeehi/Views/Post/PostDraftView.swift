//
//  PostDraftView.swift
//  coffeehi
//
//  Created by Lyndi Castrejon on 5/23/22.
//

import SwiftUI

struct PostDraftView: View {
    var body: some View {
        
        GeometryReader { g in
            
            VStack {
                
                LogoHeader()
                
                ZStack {
                    
                    Rectangle()
                        .fill(Color(lightGray))
                        .cornerRadius(10)
                    
                    VStack(alignment: .leading) {
                        
                        HStack {
                            
                            ProfileImage(width: 35, photo: "travis")
                            Text("Share something...")
                            
                            Spacer()
                        }
                        .padding()
                        
                        Spacer()
                        
                        HStack {
                            
                            Button(action: {}, label: {
                             
                                Text("Cancel")
                                    .bold()
                                    .foregroundColor(Color(primaryColor))
                            })
                            
                            Spacer()
                            
                            ZStack {
                                
                                Rectangle()
                                    .fill(Color(primaryColor))
                                    .frame(width: 100, height: 35)
                                    .cornerRadius(20)
                                
                                Text("Post")
                                    .bold()
                                    .foregroundColor(.white)
                            }
                        }
                        .padding([.leading, .trailing], 25)
                        .padding([.top, .bottom])
                    }
                }
                .frame(minHeight: g.size.height / 2)
                .padding()
            }
        }
    }
}

struct PostDraftView_Previews: PreviewProvider {
    static var previews: some View {
        PostDraftView()
    }
}
