//
//  PostDetailView.swift
//  coffeehi
//
//  Created by Lyndi Castrejon on 5/19/22.
//

import SwiftUI

struct PostDetailView: View {
    var body: some View {
        
        GeometryReader { g in
            
            ScrollView(showsIndicators: false) {
                
                LazyVStack {
                    
                    LogoHeader()
                    
                    PostView(width: g.size.width - 30)
                        .frame(maxHeight: 600)
                    
                    // TODO: Add comments
                }
            }
        }
    }
}

struct PostDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PostDetailView()
    }
}
