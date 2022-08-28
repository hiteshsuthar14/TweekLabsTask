//
//  ProxyTabViews.swift
//  TweekLabs
//
//  Created by Hitesh Suthar on 15/08/22.
//

import SwiftUI

struct ProxyTabViews: View {
    enum FilterType {
        case news, myKits, home, leaderboard, account
    }
    let filter: FilterType
    var body: some View {
        Text("This is \(tabName) Tab")
    }
    var tabName: String {
        switch filter {
        case .news:
            return "News"
        case .myKits:
            return "MyKits"
        case .home:
            return "Home"
        case .leaderboard:
            return "Leaderboard"
        case .account:
            return "Account"
        }
    }
}

struct ProxyTabViews_Previews: PreviewProvider {
    static var previews: some View {
        ProxyTabViews(filter: .home)
    }
}
