//
//  AppWidget.swift
//  AppWidget
//
//  Created by SmartLabs on 9/21/20.
//

import WidgetKit
import SwiftUI

@main
struct AppWidget: Widget {
    let kind: String = "AppWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            CalendarWidgetView(entry: entry, manager: WidgetManager())
        }
        .supportedFamilies([.systemMedium])
        .configurationDisplayName("Calendar Widget")
        .description("Design your own calendar widget")
    }
}

// MARK: - Render UI
struct AppWidget_Previews: PreviewProvider {
    static var previews: some View {
        CalendarWidgetView(entry: CalendarEntry(date: Date()), manager: WidgetManager())
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
