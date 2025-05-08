//
//  AI_TwinApp.swift
//  AI-Twin
//
//  Created by Dominic Kchau on 05/05/2025.
//

import SwiftUI

@main
struct AI_TwinApp: App {
    let persistenceController = CoreDataManager.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.context)
        }
    }
}
