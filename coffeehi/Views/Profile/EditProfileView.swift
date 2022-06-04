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
        
        // Change profile image
        TextField("PFP", text: $pfp)
        
        // Update bio
        TextField("Bio", text: $bio)
        
        // Save data button
        Button {
            model.updateProfile(bio: bio, pfp: pfp)
            
            // Dismiss sheet
            DispatchQueue.main.async {
                editProfileVisible = false
            }
        } label: {
            Text("Save")
        }

    }
}

struct EditProfileView_Previews: PreviewProvider {
    
    @State static var editProfileVisible = true
    
    static var previews: some View {
        EditProfileView(editProfileVisible: $editProfileVisible)
    }
}
