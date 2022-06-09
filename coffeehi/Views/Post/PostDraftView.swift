//
//  PostDraftView.swift
//  coffeehi
//
//  Created by Lyndi Castrejon on 5/23/22.
//

import SwiftUI

struct PostDraftView: View {
    
    @EnvironmentObject var model: ContentModel
    @State var postBody: String = ""
    
    // Remove default background color on text editor
    init() {
        UITextView.appearance().backgroundColor = .clear
    }
    
    // TODO: Fix text editor style and rethink alignment/organization
    var body: some View {
        
        GeometryReader { g in
            
            VStack {
                
                LogoHeader()
                ZStack {
                    
                    Rectangle()
                        .fill(Color.lightGray)
                        .cornerRadius(10)
                    
                    VStack(alignment: .leading) {
                        
                        HStack(alignment: .top) {
                            
                            ProfileImage(width: 35, photo: "travis")

                            TextEditor(text: $postBody)
                                .foregroundColor(Color.kellyGreen)
                                .background(Color.lightGray)
                        
                            Spacer()
                        }
                        .padding()
                        
                        Spacer()
                        
                        // TODO: If canceled, prompt user if they would like to save as draft
                        // TODO: Create "draftPost" method
                        HStack {
                            
                            Button(action: {}, label: {
                             
                                Text("Cancel")
                                    .bold()
                                    .foregroundColor(Color.kellyGreen)
                            })
                            
                            Spacer()
                            
                            Button {
                                
                                // Method
                                model.createPost(postBody: postBody)
                            } label: {
                                
                                ThemeButtonLabel(buttonText: "Post", width: 100, height: 35, tracking: 0)
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
