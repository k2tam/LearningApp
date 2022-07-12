//
//  LearningAppApp.swift
//  LearningApp
//
//  Created by k2 tam on 12/07/2022.
//

import SwiftUI

@main
struct LearningApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(ContentModel())
        }
    }
}
