//
//  ContentView.swift
//  myWeatherForecast
//
//  Created by Jan Stusio on 19/10/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var locationManager = LocationDataManager()
    
    @State var isCelcius = true
    @State var weather: ForecastWeatherResponseBody?
    @State var iconList: ConditionIcons
    @State var weatherConditions: [KnownWeatherCondition]
    
    var weatherManager = WeatherManager()
        
    var body: some View {
        ZStack {
            let isDay = weather?.current.is_day == 1 ? true : false
            
            Color("Background")
                .ignoresSafeArea()
                .preferredColorScheme(isDay ? .light : .dark)
            
            VStack {
                HStack {
                    //This indicates if user shared his location
                    Image(systemName: locationManager.authorizationStatus == .authorizedWhenInUse
                          ? "location.fill"
                          : "location")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                    
                    Text(weather?.location.name ?? "Unknown location")
                    
                    Spacer()
                    
                    //Button that allows user to chose C or F
                    Button(isCelcius==true ? "°C" : "°F") {
                        isCelcius.toggle()
                    }
                    .buttonStyle(.automatic)
                }
                .padding()
                Spacer()
                if let location = locationManager.location {
                    if let weather = weather {
                        
                        WeatherView(weatherConditions: weatherConditions,iconList: iconList, weather: weather, isCelcius: isCelcius, isDay: isDay)
                        
                        Spacer()

                        ForecastView(weatherConditions: weatherConditions,iconList: iconList, weather: weather, isCelcius: isCelcius, isDay: isDay)
                        
                    } else {
                        LoadingView()
                            .task {
                                do {
                                    weather = try await weatherManager.fetchWeatherDataFromAPI(latitude: location.latitude, longitude: location.longitude)
                                } catch {
                                    print("Error getting weather: \(error)")
                                }
                            }
                    }
                } else {
                    LoadingView()
                }
            }
        }
    }
}

#Preview {
    ContentView(iconList: iconList, weatherConditions: weatherConditions)
}
