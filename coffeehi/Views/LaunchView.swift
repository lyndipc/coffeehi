//
//  LaunchView.swift
//  coffeehi
//
//  Created by Lyndi Castrejon on 5/14/22.
//

import SwiftUI

struct LaunchView: View {
    
    private let tabBarImageNames = ["house", "arrow-trend", "square-plus", "bell", "bell"]
    
    @EnvironmentObject var userController: UserController
    @State private var selectedIndex: Int = 0
    @State var showPostDraft: Bool = false
    @State var lastIndex = 0
    
    var body: some View {
        VStack(spacing: 0.0) {
            
            // TODO: Authenticate user prior to showing FeedView
            if userController.loggedIn == false {
                
                // Display LoginView() if user is not logged in
                AuthenticationView()
                    .onAppear {
                        userController.checkLogin()
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
                        FeedView()
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
                            
                            // Set the last index prior to button tap
                            lastIndex = selectedIndex
                            
                            // Set index of button that user tapped
                            selectedIndex = index
                            
                            // If draft icon is selected, show PostDraftView
                            if index == 2 {
                                showPostDraft = true
                                selectedIndex = lastIndex
                            }
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
                        .sheet(isPresented: $showPostDraft) {
                            PostDraftView(showPostDraft: $showPostDraft)
                        }
                    }
                }
                .frame(height: 50)
            }
        }
        .background(Color.background)
    }
        
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
            .environmentObject(PostController())
    }
}
