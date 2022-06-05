//
//  EditProfileView.swift
//  coffeehi
//
//  Created by Lyndi Castrejon on 6/3/22.
//

import SwiftUI

// TODO: Create profile editor view for sheet

struct EditProfileView: View {
    
    @EnvironmentObject var model: ContentModel
    @State var bio: String = ""
    @State var pfp: String = ""
    @Binding var editProfileVisible: Bool
    var user = UserService.shared.user
    
    var body: some View {
        
        GeometryReader { g in
            
            VStack(alignment: .center) {
                
                Spacer()
                
                VStack(spacing: 25.0) {
                    
                    // TODO: update UI based on whether or not fields are populated
                    
                    // Check if profile image field is already populated
                    let userPfp = user.pfp != "" ? user.pfp : "Profile Image"
                    
                    // Change profile image
                    FormField(value: $pfp, label: "profile image", placeholder: userPfp, width: g.size.width - 60)
                    
                    // Check if user bio field is already populated
                    let userBio = user.bio != "" ? user.bio : "Bio"
                    
                    // Update bio
                    FormField(value: $bio, label: "bio", placeholder: userBio, width: g.size.width - 60)
                }
                
                Spacer()
                
                // Save data button
                Button {
                    
                    // Update user profile with new changes
                    model.updateProfile(bio: bio, pfp: pfp)
                    
                    // Dismiss sheet
                    DispatchQueue.main.async {
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
        .background(Color(darkGray.cgColor))
    }
}

struct EditProfileView_Previews: PreviewProvider {
    
    @State static var editProfileVisible = true
    
    static var previews: some View {
        EditProfileView(editProfileVisible: $editProfileVisible)
    }
}
