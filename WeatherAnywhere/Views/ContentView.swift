//
//  ContentView.swift
//  WeatherAnywhere
//
//  Created by Мирсаит Сабирзянов on 16.05.2024.
//

import SwiftUI
import CoreLocationUI
import CoreLocation

struct ContentView: View {
    
    @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherManager()
    @State private var weather: Weather?
    @StateObject private var appState = AppState()
    var newLocationsManager = NewLocationManager()
    @State var myLocation: Location? = nil
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.main.ignoresSafeArea()
                VStack {
                    if let weather = weather {
                        Text(myLocation?.name ?? weather.name)
                            .font(.title)
                        Text("\(weather.main.temp, specifier: "%.0f") ℃")
                            .bold()
                    } else {
                        ProgressView()
                        
                        if locationManager.authorizationStatus == .denied || locationManager.authorizationStatus == .restricted {
                            VStack {
                                Text("Permission to access the location has not been granted.")
                                    .padding()
                                
                                LocationButton(.sendMyCurrentLocation) {
                                    locationManager.requestLocation()
                                }
                            }
                        }
                    }
                }
                .foregroundStyle(.cream)
                .frame(width: 300, height: 300)
                .background(.aquablue)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding(30)
                .shadow(radius: 20)
                .navigationTitle("WeatherAnywhere")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        NavigationLink {
                            LocationListView()
                        } label: {
                            Image(systemName: "magnifyingglass.circle")
                        }
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        NavigationLink {
                            LikedView()
                        } label: {
                            Image(systemName: "heart.circle")
                        }
                    }
                    
                    ToolbarItem(placement: .topBarLeading) {
                        NavigationLink {
                            SettingsView()
                        } label: {
                            Image(systemName: "gear")
                        }
                    }
                }
            }
            .onAppear {
                locationManager.requestLocation()
            }
            .onReceive(locationManager.$location) { coordinate in
                Task {
                    await updateWeather(coordinate: coordinate)
                }
            }
        }
        .environmentObject(appState)
        
    }
    
    private func updateWeather(coordinate: CLLocationCoordinate2D?) async {
        do {
            if let selectedLocation = appState.currentCity {
                myLocation = selectedLocation
            } else {
                if let latitude = coordinate?.latitude, let longitude = coordinate?.longitude {
                    let locations = try await newLocationsManager.fetchLocationsByCoordinates(lat: latitude, lon: longitude)
                    myLocation = locations.first
                }
            }
            
            if let myLocation = myLocation {
                weather = try await weatherManager.fetchWeather(latitude: myLocation.lat, longitude: myLocation.lon)
            }
        } catch {
            print("Failed to get weather: \(error.localizedDescription)")
        }
    }
}

#Preview {
    ContentView()
}
