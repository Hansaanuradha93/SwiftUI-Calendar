//
//  ContentView.swift
//  Calendar
//
//  Created by Hansa Anuradha on 2023-02-01.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Day.date, ascending: true)],
        animation: .default)
    private var days: FetchedResults<Day>

    var body: some View {
        NavigationView {
            List {
                ForEach(days) { day in
                    Text(day.date!.formatted())
                }
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
