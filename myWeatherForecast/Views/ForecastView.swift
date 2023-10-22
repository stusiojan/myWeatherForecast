//
//  ForecastView.swift
//  myWeatherForecast
//
//  Created by Jan Stusio on 20/10/2023.
//

import SwiftUI

struct ForecastView: View {
    
    var weatherConditions: [KnownWeatherCondition]
    var iconList: ConditionIcons
    var weather: ForecastWeatherResponseBody
    var isCelcius: Bool
    var isDay: Bool
    
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false){
            HStack(alignment: .center){
                ForEach(weather.forecast.forecastday.dropFirst(), id: \.self) {forecast in
                    HStack{
                        let forecastIcon = determineForecastIcon(weatherConditions: weatherConditions, iconList: iconList, forecasts: forecast)
                        let dayOfTheWeek = determineDayOfWeek(forecast: forecast)
                        
                        Image(systemName: forecastIcon)//SF symbol for current weather
                            .resizable()
                            .scaledToFit()
                            .frame(minWidth: 80.0, maxWidth: 150.0, minHeight: 80.0, maxHeight: 150.0)
                        
                        VStack{
                            Text(dayOfTheWeek)//display day of the week
                            
                            Text(isCelcius==true ? "\(forecast.day.avgtemp_c.roundDouble())°C" : "\(forecast.day.avgtemp_f.roundDouble())°F")
                                .bold()
                                .font(.system(size: 30.0))
                            
                            Text(forecast.day.condition.text)
                        }
                    }
                    .padding()
                    .padding(.horizontal)
                }
            }
        }
        .background(isDay ? Color.init(red: 0.5, green: 0.7, blue: 0.75).opacity(0.5) : .teal.opacity(0.5))
    }
    
    func determineForecastIcon(weatherConditions: [KnownWeatherCondition], iconList :ConditionIcons, forecasts: ForecastDayResponse) -> String {
        var weatherIconSymbol = ""
        for weatherCondition in weatherConditions {
            if forecasts.day.condition.text == weatherCondition.day {
                weatherIconSymbol = iconList.iconDay[String(weatherCondition.icon)]!//force unwrap because without decoded JSON data the App will not run this func
            }
        }
        return weatherIconSymbol
    }
    
    func determineDayOfWeek(forecast: ForecastDayResponse) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
        guard let date = dateFormatter.date(from: forecast.date) else {
                return "Invalid Date"
            }
            
            let calendar = Calendar.current
            let components = calendar.dateComponents([.weekday], from: date)
            
            if let weekday = components.weekday {
                let weekdaySymbols = dateFormatter.weekdaySymbols
                return weekdaySymbols![weekday - 1]//force unwrap because without fetched data the App will not run this func
            } else {
                return forecast.date
            }
        }
}

#Preview {
    ForecastView(weatherConditions: weatherConditions,iconList: iconList,weather: previewWeather, isCelcius: false, isDay: true)
}
