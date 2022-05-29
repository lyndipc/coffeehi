//
//  coffeehiApp.swift
//  coffeehi
//
//  Created by Lyndi Castrejon on 5/14/22.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore

@main
struct coffeehiApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            LaunchView()
                .environmentObject(ContentModel())
        }
    }
}
