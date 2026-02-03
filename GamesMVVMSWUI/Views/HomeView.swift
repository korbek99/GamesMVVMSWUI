//
//  HomeView.swift
//  GamesMVVMSWUI
//
//  Created by Jose Preatorian on 03-02-26.
//

import SwiftUI

struct HomeView: View {
    @State private var selectedTab = 0
    @State private var showMenu = false

    var body: some View {
        TabView(selection: $selectedTab) {

            CommingSoonView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag(0)
            
           GamesView()
                .tabItem {
                    Label("Games", systemImage: "gamecontroller.fill")
                }
                .tag(1)
            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "heart.fill")
                }
                .tag(2)

            InfoView()
                .tabItem {
                    Label("Info", systemImage: "info.circle.fill")
                }
                .tag(3)
        }
        .accentColor(.red)
    }
}


#Preview {
    HomeView()
}
