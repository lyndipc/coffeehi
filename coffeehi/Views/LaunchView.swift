//
//  LaunchView.swift
//  coffeehi
//
//  Created by Lyndi Castrejon on 5/14/22.
//

import SwiftUI

// Theme colors
let primaryColor = UIColor(red: 0.016, green: 0.767, blue: 0.541, alpha: 1)
let offWhite = UIColor(red: 229, green: 229, blue: 229, alpha: 0.5)
let darkGray = UIColor(red: 0, green: 0, blue: 0, alpha: 0.68)
let lightGray = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)

struct LaunchView: View {
    
    private let tabBarImageNames = ["house", "arrow-trend", "square-plus", "bell", "bell"]
    
    @EnvironmentObject var model: ContentModel
    @State private var selectedIndex = 0
    
    var body: some View {
        VStack(spacing: 0.0) {
            
            // TODO: Authenticate user prior to showing FeedView
            if model.loggedIn == false {
                
                // Display LoginView() if user is not logged in
                AuthenticationView()
                    .onAppear {
                        model.checkLogin()
                    }
            }
            else {
                
                ZStack {
                    
                    switch selectedIndex {
                    case 0:
                        FeedView()
                    case 1:
                        TrendingView()
                    case 2:
                        PostDraftView()
                    case 3:
                        NotificationView()
                    case 4:
                        ProfileView()
                    default:
                        FeedView()
                    }
                }
                
                Divider()
                    .padding(.bottom, 8)
                
                HStack(alignment: .center, spacing: 0.0) {
                    ForEach(0..<5) { index in
                        
                        Button(action: {
                            
                            selectedIndex = index
                        }, label: {
                            
                            Spacer()
                            
                            if index == 4 {
                                ProfileImage(width: 35, photo: "travis")
                            }
                            else {
                                Image(tabBarImageNames[index])
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 25)
                            }
                            
                            Spacer()
                        })
                    }
                }
                .frame(height: 50)
            }
        }
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
