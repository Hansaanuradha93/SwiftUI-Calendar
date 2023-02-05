//
//  CalendarHeaderView.swift
//  Calendar
//
//  Created by Hansa Anuradha on 2023-02-04.
//

import SwiftUI

struct CalendarHeaderView: View {
    
    private let daysOfWeek = ["S", "M", "T", "W", "T", "F", "S"]
    var font: Font = .body

    var body: some View {
        HStack {
            ForEach(daysOfWeek, id: \.self) { daysOfWeek in
                Text(daysOfWeek)
                    .font(font)
                    .fontWeight(.bold)
                    .foregroundColor(.orange)
                    .frame(maxWidth: .infinity)
            }
        }
    }
}

struct CalendarHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarHeaderView()
    }
}
