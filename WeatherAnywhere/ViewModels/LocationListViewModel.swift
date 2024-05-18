//
//  LocationListViewModel.swift
//  WeatherAnywhere
//
//  Created by Мирсаит Сабирзянов on 18.05.2024.
//

import Foundation

extension LocationListView {
    @Observable
    class ViewModel {
        func removeDuplicates(from locations: [Location]) -> [Location] {
            var seen = Set<Location>()
            return locations.filter { location in
                if seen.contains(location) {
                    return false
                } else {
                    seen.insert(location)
                    return true
                }
            }
        }
    }
}
