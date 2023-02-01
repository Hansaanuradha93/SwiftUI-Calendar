//
//  CalendarApp.swift
//  Calendar
//
//  Created by Hansa Anuradha on 2023-02-01.
//

import SwiftUI

@main
struct CalendarApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
