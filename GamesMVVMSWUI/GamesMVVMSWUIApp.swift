//
//  GamesMVVMSWUIApp.swift
//  GamesMVVMSWUI
//
//  Created by Jose Preatorian on 03-02-26.
//

import SwiftUI

@main
struct GamesMVVMSWUIApp: App {
    var body: some Scene {
        WindowGroup {
            LaunchView()
        }
        .modelContainer(for: FavoriteGame.self)
    }
}
