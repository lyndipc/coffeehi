//
//  PullRefresh.swift
//  coffeehi
//
//  Created by Lyndi Castrejon on 6/6/22.
//

import SwiftUI

struct PullRefresh: View {
    
    @State var needRefresh: Bool = false
    
    var coordinateSpaceName: String
    var onRefresh: () -> Void
    
    var body: some View {
        
        GeometryReader { g in
            
            if g.frame(in: .named(coordinateSpaceName)).midY > 50 {
                
                Spacer()
                    .onAppear {
                        needRefresh = true
                    }
            }
            else if g.frame(in: .named(coordinateSpaceName)).maxY < 10 {
                
                Spacer()
                    .onAppear {
                        // Once pull refresh has contracted, reset needRefresh
                        if needRefresh {
                            needRefresh = false
                            onRefresh()
                        }
                    }
            }
            
            HStack {
                
                Spacer()
                
                if needRefresh {
                    ProgressView()
                }
                else {
                    Image("down-long-solid")
                        .resizable()
                        .frame(width: 18, height: 30)
                }
                
                Spacer()
            }
        }
        .padding(.top, -50.0)
    }
}
