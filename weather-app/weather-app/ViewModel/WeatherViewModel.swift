//
//  WeatherViewModel.swift
//  weather-app
//
//  Created by Jonathan Bigbee on 3/23/23.
//

import Foundation

class weatherViewModel: ObservableObject {
    private let weatherService = OpenWeatherMapController()
    
    @Published var weatherInfo = ""
    
    func fetch (city: String) {
        weatherService.fetchWeatherData(for: city) {(info, error) in
            guard error == nil,
                  let weatherInfo = info else {
                DispatchQueue.main.async {
                    self.weatherInfo = "Could not retrieve weather information for \(city)"
                }
                return
            }
            DispatchQueue.main.async {
                self.weatherInfo = weatherInfo
            }
        }
    }
}
