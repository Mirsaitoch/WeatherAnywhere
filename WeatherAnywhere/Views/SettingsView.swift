//
//  SettingsView.swift
//  WeatherAnywhere
//
//  Created by Мирсаит Сабирзянов on 18.05.2024.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        ZStack {
            Color.main.ignoresSafeArea()
            Spacer()
            Button {
                appState.currentCity = nil
            } label: {
                Text("Delete the default city")
                    .foregroundStyle(.mainSecond)
                    .padding()
                    .overlay {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(.secondary)
                    }
                    .disabled(appState.currentCity == nil)
            }
        }
    }
}

#Preview {
    Button {
        print("удаляем город по умолчанию")
//        appState.currentCity = nil
    } label: {
        Text("Delete the default city")
            .foregroundStyle(.mainSecond)
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(.secondary)
            }
    }
}
