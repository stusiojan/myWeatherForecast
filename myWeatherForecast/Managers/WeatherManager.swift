//
//  WeatherManager.swift
//  myWeatherForecast
//
//  Created by Jan Stusio on 19/10/2023.
//

import Foundation
import CoreLocation

class WeatherManager {
    
    let apiKey = "8c3858afff314b0abee92658232010"
    
    func fetchWeatherDataFromAPI(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> ForecastWeatherResponseBody {
        //creating a URL
        guard let url = URL(string: "http://api.weatherapi.com/v1/forecast.json?key=\(apiKey)&q=\(latitude),\(longitude)&days=4&aqi=no&alerts=no") else { fatalError("Wrong URL") }

        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching current weather data") }
        
        let decodedData = try JSONDecoder().decode(ForecastWeatherResponseBody.self, from: data)
        
        return decodedData
    }
}

//ResponseBody structure
struct ForecastWeatherResponseBody: Codable, Hashable {
    var location: LocationResponse
    var current: CurrentResponse
    var forecast: ForecastResponse
}

struct LocationResponse: Codable, Hashable {
    var name: String
    var localtime: String
}

struct CurrentResponse: Codable, Hashable {
    var temp_c: Double
    var temp_f: Double
    var is_day: Int
    var condition: ConditionResponse
}

struct ForecastResponse: Codable, Hashable {
    var forecastday: [ForecastDayResponse]
}

struct ForecastDayResponse: Codable, Hashable {
    var date: String
    var day: DayResponse
}

struct DayResponse: Codable, Hashable {
    var avgtemp_c: Double
    var avgtemp_f: Double
    var daily_chance_of_rain: Int
    var condition: ConditionResponse
}

struct ConditionResponse: Codable, Hashable {
    var text: String
}
        
