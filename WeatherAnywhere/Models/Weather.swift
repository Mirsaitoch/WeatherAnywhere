//
//  Weather.swift
//  WeatherAnywhere
//
//  Created by Мирсаит Сабирзянов on 16.05.2024.
//

import Foundation

struct Weather: Codable {
    let weather: [Weather]
    let main: Main
    let name: String
    
    struct Weather: Codable {
        let description: String
    }

    struct Main: Codable {
        let temp: Double
    }
}




