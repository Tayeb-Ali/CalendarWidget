//
//  CalendarWidgetApp.swift
//  CalendarWidget
//
//  Created by SmartLabs on 9/21/20.
//

import SwiftUI

@main
struct CalendarWidgetApp: App {
    var body: some Scene {
        return WindowGroup {
            MainContentView(manager: WidgetManager())
        }
    }
}
