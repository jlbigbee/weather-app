//
//  OpenWeatherMapController.swift
//  weather-app
//
//  Created by Jonathan Bigbee on 3/22/23.
//

import Foundation

private enum API {
    static let key = "df9abd319fadbcc6403aa47be5476b9e"
}

class OpenWeatherMapController: WebServiceController {
    func fetchWeatherData(for city: String, completionHandler: (String?, WebServiceControllerError?) -> Void) {
        //    api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}
        let endpoint = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(API.key)"
        
        guard let safeURLString = endpoint.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed),
              let endpointURL = URL(string: safeURLString) else {
            completionHandler(nil, WebServiceControllerError.invalidURL(endpoint))
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: endpointURL) { (data, response, error) in
            guard error == nil else {
                completionHandler(nil, WebServiceControllerError.forwarded(error!))
                return
            }
            guard let responseData = data else {
                completionHandler(nil, WebServiceControllerError.invalidPayload(endpointURL))
                return
            }
            
            
            // decode json
            let decoder = JSONDecoder()
            do {
                let weatherList = try decoder.decode(OpenWeatherMapContainer.self, from: responseData)
                guard let weatherInfo = weatherList.list?.first,
                      let weather = weatherInfo.weather.first?.main,
                      let temperature = weatherInfo.main.temp else {
                    completionHandler(nil, WebServiceControllerError.invalidPayload(endpointURL))
                    return
                }
                
                // compose weather information
                let weatherDescription = "\(weather) \(temperature) °F"
                completionHandler(weatherDescription, nil)
            } catch let error {
                completionHandler(nil, WebServiceControllerError.forwarded(error))
            }
        }
        dataTask.resume()
    }
}

