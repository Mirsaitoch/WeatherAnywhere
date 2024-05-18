//
//  Location.swift
//  WeatherAnywhere
//
//  Created by Мирсаит Сабирзянов on 16.05.2024.
//

import Foundation
import SwiftData

@Model
class Location: Identifiable, Hashable, Codable {
    var id: String { "\(name)_\(lat)_\(lon)" }
    let name: String
    let lat: Double
    let lon: Double
    let country: String
    
    init(name: String, lat: Double, lon: Double, country: String) {
        self.name = name
        self.lat = lat
        self.lon = lon
        self.country = country
    }
    
    enum CodingKeys: String, CodingKey {
        case name, lat, lon, country
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        lat = try container.decode(Double.self, forKey: .lat)
        lon = try container.decode(Double.self, forKey: .lon)
        country = try container.decode(String.self, forKey: .country)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(lat, forKey: .lat)
        try container.encode(lon, forKey: .lon)
        try container.encode(country, forKey: .country)
    }
    
    static func == (lhs: Location, rhs: Location) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

