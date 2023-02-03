//
//  WeatherManager.swift
//  Another Weather
//
//  Created by Konstantin Grachev on 03.02.2023.
//

import Foundation

class WeatherManager {
    let baseURL = "https://api.openweathermap.org/data/2.5/weather?appid=696acdd74f5773b5cdbe3ff6efa280f7&units=metric&q="
    
    func fetchWeatherData(for city: String) {
        let url = baseURL + city
        print(url)
    }
}
