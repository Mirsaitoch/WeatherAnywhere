//
//  LocationListView.swift
//  WeatherAnywhere
//
//  Created by Мирсаит Сабирзянов on 16.05.2024.
//

import SwiftUI

struct LocationListView: View {
    @EnvironmentObject var appState: AppState
    @State private var locationName = ""
    var newLocationsManager = NewLocationManager()
    @State private var locations: [Location] = []
    private var viewModel = ViewModel()
    
    var body: some View {
        ZStack {
            Color.main.ignoresSafeArea()
            VStack {
                if !locations.isEmpty {
                    List(locations) { location in
                        NavigationLink(destination: LocationView(location: location)) {
                            VStack(alignment: .leading) {
                                Text("\(location.name) (\(location.country))")
                                    .font(.headline)
                                Text("Широта: \(location.lat)")
                                Text("Долгота: \(location.lon)")
                            }
                        }
                        .listRowBackground(Color.clear)
                    }
                    .background(Color.clear)
                    .scrollContentBackground(.hidden)
                } else {
                    Image(systemName: "sun.min")
                        .font(.system(size: 40))
                }
            }
            .navigationTitle("Search")
            .searchable(text: $locationName)
            .onChange(of: locationName) { _, _ in
                locations = []
                Task {
                    do {
                        let fetchedLocations = try await newLocationsManager.fetchLocations(name: locationName)
                        locations = viewModel.removeDuplicates(from: fetchedLocations)
                        
                    } catch {
                        print("Ошибка при поиске новых местоположений: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
}

#Preview {
    LocationListView()
}

