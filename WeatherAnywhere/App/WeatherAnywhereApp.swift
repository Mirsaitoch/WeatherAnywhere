//
//  WeatherAnywhereApp.swift
//  WeatherAnywhere
//
//  Created by Мирсаит Сабирзянов on 16.05.2024.
//

import SwiftUI
import SwiftData

@main
struct WeatherAnywhereApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Location.self)
    }
}
