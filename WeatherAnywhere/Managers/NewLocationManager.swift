//
//  NewLocationManager.swift
//  WeatherAnywhere
//
//  Created by Мирсаит Сабирзянов on 16.05.2024.
//

import Foundation

class NewLocationManager {
    
    private var constants = Constants.shared
    
    func fetchLocations(name: String) async throws -> [Location] {
        guard let url = URL(string: "https://api.openweathermap.org/geo/1.0/direct?q=\(name)&limit=\(constants.limitLocation)&appid=\(constants.weatherAPIKey)") else {
            throw URLError(.badURL)
        }
        return try await makeRequest(url: url)
    }
    
    func fetchLocationsByCoordinates(lat: Double, lon: Double) async throws -> [Location] {
        guard let url = URL(string: "https://api.openweathermap.org/geo/1.0/reverse?lat=\(lat)&lon=\(lon)&limit=1&appid=\(constants.weatherAPIKey)") else {
            throw URLError(.badURL)
        }
        return try await makeRequest(url: url)
    }
    
    func makeRequest(url: URL) async throws -> [Location] {
        let urlRequest = URLRequest(url: url)

        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                throw URLError(.badServerResponse)
            }
            
            let decodedData = try JSONDecoder().decode([Location].self, from: data)
            return decodedData
        } catch {
            print("Ошибка при выполнении запроса: \(error.localizedDescription)")
            throw error
        }
    }
}
