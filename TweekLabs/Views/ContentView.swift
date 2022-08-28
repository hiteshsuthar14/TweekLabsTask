//
//  ContentView.swift
//  TweekLabs
//
//  Created by Hitesh Suthar on 15/08/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            ProxyTabViews(filter: .news)
                .tabItem {
                    Image("ic-nav-news")
                        .renderingMode(.template)
                    Text("News")
                        .font(.regular_11px)
                }
            
            ProxyTabViews(filter: .myKits)
                .tabItem {
                    Image("ic-nav-mykits")
                        .renderingMode(.template)
                    Text("My Kits")
                        .font(.regular_11px)
                }
            
            ProxyTabViews(filter: .home)
                .tabItem {
                    Image("ic-nav-home")
                        .renderingMode(.template)
                    Text("Home")
                        .font(.regular_11px)
                }
            
            LeaderboardView()
                .tabItem {
                    Image("ic-nav-lboard")
                        .renderingMode(.template)
                    Text("Leaderboard")
                        .font(.regular_11px)
                }
            
            ProxyTabViews(filter: .account)
                .tabItem {
                    Image("ic-nav-acc")
                        .renderingMode(.template)
                    Text("Account")
                        .font(.regular_11px)
                }
            
        }.accentColor(Color("Primary"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
