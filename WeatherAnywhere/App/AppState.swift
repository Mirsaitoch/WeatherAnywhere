//
//  AppState.swift
//  WeatherAnywhere
//
//  Created by Мирсаит Сабирзянов on 18.05.2024.
//

import Foundation


class AppState: ObservableObject {
    @Published var currentCity: Location? {
        didSet {
            saveCityToDefaults()
        }
    }
    
    init() {
        loadCityFromDefaults()
    }
    
    private func saveCityToDefaults() {
        if let city = currentCity {
            if let encoded = try? JSONEncoder().encode(city) {
                UserDefaults.standard.set(encoded, forKey: "currentCity")
            }
        }
    }
    
    private func loadCityFromDefaults() {
        if let savedCityData = UserDefaults.standard.data(forKey: "currentCity") {
            if let decodedCity = try? JSONDecoder().decode(Location.self, from: savedCityData) {
                currentCity = decodedCity
            }
        }
    }
}
