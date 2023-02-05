//
//  CalWidget.swift
//  CalWidget
//
//  Created by Hansa Anuradha on 2023-02-04.
//

import WidgetKit
import SwiftUI
import CoreData

struct Provider: TimelineProvider {
    
    let viewContext = PersistenceController.shared.container.viewContext
    
    var daysFetchRequest: NSFetchRequest<Day> {
        let request = Day.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Day.date, ascending: true)]
        request.predicate = NSPredicate(format: "(date >= %@) AND (date <= %@)",
                                        Date().startOfCalendarWithPrefixDays as CVarArg,
                                        Date().endOfMonth as CVarArg)
        
        return request
    }
    

    func placeholder(in context: Context) -> CalendarEntry {
        CalendarEntry(date: Date(), days: [])
    }

    func getSnapshot(in context: Context, completion: @escaping (CalendarEntry) -> ()) {
        do {
            let days = try viewContext.fetch(daysFetchRequest)
            let entry = CalendarEntry(date: Date(), days: days)
            completion(entry)
        } catch {
            print("❌ Widget failed to fetch days in snapshot")
        }
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        do {
            let days = try viewContext.fetch(daysFetchRequest)
            let entry = CalendarEntry(date: Date(), days: days)
            let timeline = Timeline(entries: [entry], policy: .after(.now.endOfDay))
            completion(timeline)
        } catch {
            print("❌ Widget failed to fetch days in snapshot")
        }
    }
}

struct CalendarEntry: TimelineEntry {
    let date: Date
    let days: [Day]
}

struct CalWidgetEntryView : View {
    var entry: Provider.Entry

    private let columns = Array(repeating: GridItem(.flexible()), count: 7)
    @State var streakValue = 0

    var body: some View {
        
        HStack {
            VStack {
                Text("\(streakValue)")
                    .font(.system(size: 70, weight: .bold, design: .rounded))
                    .foregroundColor(streakValue > 0 ? .orange : .pink)
                Text("Current Streak")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            VStack {
                
                CalendarHeaderView(font: .caption)
                
                LazyVGrid(columns: columns, spacing: 7) {
                    ForEach(entry.days) { day in

                        if day.date?.monthInt != Date().monthInt { // not in the current month
                            Text(day.date!.formatted(.dateTime.day()))
                                .font(.caption)
                                .bold()
                                .foregroundColor(day.didStudy ? .orange.opacity(0.3) : .secondary.opacity(0.3))
                                .frame(maxWidth: .infinity)
                                .background(
                                    Circle()
                                        .foregroundColor(.orange.opacity(day.didStudy ? 0.3 : 0.0))
                                        .scaleEffect(1.5)
                                )
                        } else {
                            Text(day.date!.formatted(.dateTime.day()))
                                .font(.caption)
                                .bold()
                                .foregroundColor(day.didStudy ? .orange : .secondary)
                                .frame(maxWidth: .infinity)
                                .background(
                                    Circle()
                                        .foregroundColor(.orange.opacity(day.didStudy ? 0.3 : 0.0))
                                        .scaleEffect(1.5)
                                )
                        }
                    }
                }
            }
        }
        .padding()
        .onAppear {
            streakValue = calculateStreakValue()
        }
    }
    
    func calculateStreakValue() -> Int {
        guard !entry.days.isEmpty else { return 0 }
        
        let nonFutureDays = entry.days.filter { $0.date!.dayInt <= Date().dayInt }
        
        var streakCount = 0
        
        for day in nonFutureDays.reversed() {
            if day.didStudy {
                streakCount += 1
            } else {
                
                if day.date!.dayInt != Date().dayInt {
                    break
                }
            }
        }
                
        return streakCount
    }
}

@main
struct CalWidget: Widget {
    let kind: String = "CalWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            CalWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemMedium])
    }
}

struct CalWidget_Previews: PreviewProvider {
    static var previews: some View {
        CalWidgetEntryView(entry: CalendarEntry(date: Date(), days: []))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
