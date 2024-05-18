//
//  WeatherManager.swift
//  WeatherAnywhere
//
//  Created by Мирсаит Сабирзянов on 16.05.2024.
//

import Foundation
import CoreLocation

class WeatherManager {
    
    private var constants = Constants.shared
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> Weather {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(constants.weatherAPIKey)&units=metric&lang=ru") else {
            throw URLError(.badURL)
        }
        
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            fatalError("error")
        }
        
        let decodeData = try JSONDecoder().decode(Weather.self, from: data)
        
        return decodeData
    }
}
