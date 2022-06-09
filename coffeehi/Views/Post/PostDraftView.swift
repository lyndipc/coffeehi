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
    @Binding var showPostDraft: Bool
    
    // Remove default background color on text editor
    init(showPostDraft: Binding<Bool>) {
        UITextView.appearance().backgroundColor = .clear
        _showPostDraft = showPostDraft
    }
    
    // TODO: Fix text editor style and rethink alignment/organization
    var body: some View {
        
        GeometryReader { g in
            
            VStack {
                
                Group {
                    
                    VStack(alignment: .leading) {
                        
                        HStack(alignment: .top) {

                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 25)
                                .foregroundColor(Color.kellyGreen)
                                .padding()
                        }
                        
                        TextEditor(text: $postBody)
                            .background(Color.background)
                            .cornerRadius(5)
                            .padding()
                        
                        Spacer()
                        
                        // TODO: If canceled, prompt user if they would like to save as draft
                        // TODO: Create "draftPost" method
                        HStack {
                            
                            Button(action: {

                                // Save text as a draft
                                
                                // Dismiss sheet
                                showPostDraft = false
                            }, label: {
                             
                                Text("Cancel")
                                    .bold()
                                    .foregroundColor(Color.kellyGreen)
                            })
                            
                            Spacer()
                            
                            Button {
                                
                                // TODO: Add completion to dismiss sheet on createPost method
                                
                                // Create new post in db
                                model.createPost(postBody: postBody)
                                
                                // Dismiss sheet
                                showPostDraft = false
                                
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
        PostDraftView(showPostDraft: .constant(true))
    }
}
