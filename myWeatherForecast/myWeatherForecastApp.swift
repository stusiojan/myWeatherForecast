//
//  myWeatherForecastApp.swift
//  myWeatherForecast
//
//  Created by Jan Stusio on 19/10/2023.
//

import SwiftUI

@main
struct myWeatherForecastApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(iconList: iconList, weatherConditions: weatherConditions)
        }
    }
}
