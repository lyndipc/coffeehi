//
//  LaunchView.swift
//  coffeehi
//
//  Created by Lyndi Castrejon on 5/14/22.
//

import SwiftUI

let primaryColor = UIColor(red: 0.016, green: 0.767, blue: 0.541, alpha: 1)

struct LaunchView: View {
    var body: some View {
        VStack {
            
            // TODO: Authenticate user prior to showing FeedView
            FeedView()
        }
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
