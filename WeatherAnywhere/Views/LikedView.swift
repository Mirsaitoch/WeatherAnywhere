//
//  LikedView.swift
//  WeatherAnywhere
//
//  Created by Мирсаит Сабирзянов on 18.05.2024.
//

import SwiftUI
import SwiftData

struct LikedView: View {
    
    @Environment(\.modelContext) var modelContext
    @Query var likedLocations: [Location]

    var body: some View {
        ZStack {
            Color.main.ignoresSafeArea()
            List(likedLocations) { location in
                Section {
                    NavigationLink(destination: LocationView(location: location)) {
                        VStack(alignment: .leading) {
                            Text("\(location.name) (\(location.country))")
                                .font(.headline)
                            Text("Широта: \(location.lat)")
                            Text("Долгота: \(location.lon)")
                        }
                    }
                }
                .padding(20)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.mainSecond, lineWidth: 3)
                }
                .swipeActions {
                    Button("Delete", systemImage: "heart.slash.fill", role: .destructive) {
                        modelContext.delete(location)
                    }
                }
                .listRowBackground(Color.clear)
            }
            .scrollContentBackground(.hidden)
        }
        .navigationTitle("Liked")
    }
    
    func delete(_ indexSet: IndexSet) {
        for i in indexSet {
            let location = likedLocations[i]
            modelContext.delete(location)
        }
    }
}

#Preview {
    LikedView()
}
