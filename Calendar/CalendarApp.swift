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
    @State private var selectedTab = 0

    var body: some Scene {
        WindowGroup {
            TabView(selection: $selectedTab) {
                CalendarView()
                    .tabItem { Label("Calendar", systemImage: "calendar") }
                    .tag(0)
                
                StreakView()
                    .tabItem { Label("Streakss", systemImage: "swift") }
                    .tag(1)
            }
            .environment(\.managedObjectContext, persistenceController.container.viewContext)
            .onOpenURL { url in
                selectedTab = url.absoluteString == "calendar" ? 0 : 1
            }
        }
    }
}
