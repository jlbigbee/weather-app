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
    }
    
    
}

