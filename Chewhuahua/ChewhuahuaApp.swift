//
//  ChewhuahuaApp.swift
//  Chewhuahua
//
//  Created by Pavel Uvarov on 2021-11-05.
//

import SwiftUI

@main
struct ChewhuahuaApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
