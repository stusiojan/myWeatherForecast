//
//  BundleDecoder.swift
//  myWeatherForecast
//
//  Created by Jan Stusio on 20/10/2023.
//

import Foundation

//decoding icons
let iconList: ConditionIcons = Bundle.main.load("IconList.json")

//decoding all possible fetched weather condisions data from local JSON
let weatherConditions: [KnownWeatherCondition] = Bundle.main.load("WeatherConditions.json")

//decoding data to preview Weather in views
var previewWeather: ForecastWeatherResponseBody = Bundle.main.load("PreviewWeatherContent.json")


//Response Body structure for fetched all possible weather condisions data decoded from local JSON
struct KnownWeatherCondition: Codable {
    let day, night: String
    let icon: Int
}

//Response Body structure for SF Symbols icons name decoded from local JSON
struct ConditionIcons: Codable {
    let iconDay, iconNight: [String: String]
}


