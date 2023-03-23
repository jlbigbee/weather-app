//
//  WebServiceController.swift
//  weather-app
//
//  Created by Jonathan Bigbee on 3/22/23.
//

import Foundation

public enum WebServiceControllerError: Error {
    case invalidURL(String)
    case invalidPayload(URL)
    case forwarded(Error)
}

public protocol WebServiceController {
    func fetchWeatherData(for city: String, completionHandler: @escaping (String?, WebServiceControllerError?) -> Void)
}
