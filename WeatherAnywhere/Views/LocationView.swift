//
//  LocationView.swift
//  WeatherAnywhere
//
//  Created by Мирсаит Сабирзянов on 18.05.2024.
//

import SwiftUI
import SwiftData

struct LocationView: View {
    var location: Location
    var weatherManager = WeatherManager()
    @State private var weather: Weather?
    @State private var isLiked = false

    @Environment(\.modelContext) var modelContext
    
    @EnvironmentObject var appState: AppState

    @Query var likedLocations: [Location]
    
    var body: some View {
        ZStack {
            Color.main.ignoresSafeArea()
            VStack {
                if let weather = weather {
                    Spacer()
                    
                    Text(location.name)
                        .font(.title)
                    Text("\(weather.main.temp, specifier: "%.0f") ℃")
                        .bold()
                    
                    Spacer()
                                        
                    if appState.currentCity != location {
                        Button {
                            appState.currentCity = location
                        } label: {
                            Text("Make it the default city")
                                .foregroundStyle(.main)
                                .padding()
                                .overlay {
                                    Capsule()
                                        .foregroundStyle(.secondary)
                                }
                        }
                        Spacer()
                    }
                } else {
                    ProgressView()
                }
            }
            .foregroundStyle(.main)
            .frame(width: 300, height: 300)
            .background(.aquablue)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .padding(30)
            .shadow(radius: 20)
            .overlay {
                Image(systemName: isLiked ? "heart.fill" : "heart")
                    .offset(x: 120, y: -120)
                    .font(.system(size: 30))
                    .foregroundStyle(.red)
                    .onTapGesture {
                        if let likedLocation = likedLocations.first(where: { $0.name == location.name }) {
                            modelContext.delete(likedLocation)
                        } else {
                            modelContext.insert(location)
                        }
                        
                        withAnimation {
                            isLiked.toggle()
                        }
                    }
            }
            .onAppear {
                isLiked = likedLocations.contains(where: { $0.name == location.name })
                Task {
                    do {
                        weather = try await weatherManager.fetchWeather(latitude: location.lat, longitude: location.lon)
                    } catch {
                        print("Error LocationView")
                    }
                }
            }
        }
    }
}

#Preview {
    LocationView(location: Location(name: "Moscow", lat: 55.755864, lon: 37.617698, country: "RU"))
}
