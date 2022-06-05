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
    
    var body: some View {
        
        GeometryReader { g in
            
            VStack(alignment: .center) {
                
                Spacer()
                
                VStack(spacing: 25.0) {
                    // Change profile image
                    FormField(value: $pfp, label: "profile image", placeholder: "Profile Image", width: g.size.width - 60)
                    
                    // Update bio
                    FormField(value: $bio, label: "bio", placeholder: "Bio", width: g.size.width - 60)
                }
                
                Spacer()
                
                // Save data button
                Button {
                    model.updateProfile(bio: bio, pfp: pfp)
                    
                    // Dismiss sheet
                    DispatchQueue.main.async {
                        editProfileVisible = false
                    }
                } label: {
                    ThemeButton(buttonText: "Save", width: g.size.width - 80)
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
