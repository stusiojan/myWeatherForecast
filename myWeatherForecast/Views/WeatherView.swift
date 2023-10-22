//
//  WeatherView.swift
//  myWeatherForecast
//
//  Created by Jan Stusio on 20/10/2023.
//

import SwiftUI

struct WeatherView: View {
    
    var weatherConditions: [KnownWeatherCondition]
    var iconList: ConditionIcons
    var weather: ForecastWeatherResponseBody
    var isCelcius: Bool
    var isDay: Bool
    
    
    
    var body: some View {
        VStack {
            VStack {
                Text("Today")
                    .font(.system(size: 30.0))
                let icon = determineIcon(weatherConditions: weatherConditions, iconList: iconList, weather: weather, isDay: isDay)
                Image(systemName: icon) //SF symbol for current weather
                    .resizable()
                    .scaledToFit()
                    .frame(minWidth: 100.0, maxWidth: 200.0, minHeight: 100.0, maxHeight: 200.0)
                
                Text(isCelcius ? "\(weather.current.temp_c.roundDouble())°C" : "\(weather.current.temp_f.roundDouble())°F")
                    .bold()
                    .font(.system(size: 60.0))
                
                Text(weather.current.condition.text)
                    .fontWeight(.semibold)
                    .font(.system(size: 30.0))
            }
        }
        .padding(.vertical, 5.0)
    }
    func determineIcon(weatherConditions: [KnownWeatherCondition], iconList :ConditionIcons, weather: ForecastWeatherResponseBody, isDay: Bool) -> String {
        var weatherIconSymbol = ""
        for weatherCondition in weatherConditions {
            if isDay && weather.current.condition.text == weatherCondition.day {
                weatherIconSymbol = iconList.iconDay[String(weatherCondition.icon)]!
            }
            if !isDay && weather.current.condition.text == weatherCondition.night {
                weatherIconSymbol = iconList.iconNight[String(weatherCondition.icon)]!
            }
        }
        return weatherIconSymbol
    }
}

#Preview {
    WeatherView(weatherConditions: weatherConditions,iconList: iconList,weather: previewWeather, isCelcius: false, isDay: true)
}
