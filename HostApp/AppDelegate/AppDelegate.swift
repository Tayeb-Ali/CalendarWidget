//
//  AppDelegate.swift
//  CalendarWidget
//
//  Created by SmartLabs on 9/22/20.
//

import SmartLabs

/// This class will initialize/configure the `SmartLabs` framework
class AppDelegate {
    static func configure() {
        WidgetConfigurator.configure(purchaseCode: "CodeCanyon_Item_Purchase_Code")
    }
}
