//
//  EditProfileView.swift
//  coffeehi
//
//  Created by Lyndi Castrejon on 6/3/22.
//

import SwiftUI

struct EditProfileView: View {
    
    @EnvironmentObject var userController: UserController
    @State var bio: String
    @State var pfp: String
    @Binding var editProfileVisible: Bool
    
    var body: some View {
        
        GeometryReader { g in
            
            VStack(alignment: .center) {
                
                Spacer()
                
                VStack(spacing: 25.0) {
                    
                    // Change profile image
                    FormField(value: $pfp, label: "profile image", placeholder: "User PFP", width: g.size.width - 60)
                    
                    // Update bio
                    FormField(value: $bio, label: "bio", placeholder: "Bio", width: g.size.width - 60)
                }
                
                Spacer()
                
                // Save data button
                Button {
                    
                    Task {
                        // Update user profile with new changes
                        await userController.updateProfile(bio: bio, pfp: pfp)
                        
                        // Dismiss sheet
                        editProfileVisible = false
                    }
                    
                } label: {
                    
                    ThemeButtonLabel(buttonText: "Update Profile", width: g.size.width - 80, tracking: 0)
                }
                .frame(width: g.size.width - 100, height: 48)
                
                Spacer()
            }
            .frame(width: g.size.width)
        }
    }
}

struct EditProfileView_Previews: PreviewProvider {

    @State static var editProfileVisible = true
    @State static var bio = "My sweet bio"
    @State static var pfp = ""

    static var previews: some View {
        EditProfileView(bio: bio, pfp: pfp, editProfileVisible: $editProfileVisible)
    }
}
