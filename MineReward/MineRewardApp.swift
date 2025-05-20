//
//  MineRewardApp.swift
//  MineReward
//
//  Created by Chris Ho on 2025-05-19.
//

import SwiftUI
import Firebase

@main
struct MineRewardApp: App {
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
