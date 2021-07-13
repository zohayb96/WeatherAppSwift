//
//  WeatherAPI.swift
//  WeatherApp
//
//  Created by Zohayb Shaikh on 7/8/21.
//
import Foundation

class WeatherAPI {
    static let shared = WeatherAPI()
    let API_KEY = "deb56f582d75a2dadcb56a97cfd656dd"
    var LATITUDE = "66.99"
    var LONGITUDE = "33.3"
    var REQUEST_URL = ""
    
    let session = URLSession(configuration: .default)
    
    func buildURL() -> String {
        REQUEST_URL = "https://api.openweathermap.org/data/2.5" + "/onecall?lat=" + LATITUDE + "&lon=" + LONGITUDE + "&units=imperial" + "&appid=" + API_KEY
        return REQUEST_URL
    }
    
    // Setters to change Lat and Long in network request URL when location is changed
    func setLatitude(_ latitude: String) {
        LATITUDE = latitude
    }
    
    func setLatitude(_ latitude: Double) {
        setLatitude(String(latitude))
    }
    
    func setLongitude(_ longitude: String) {
        LONGITUDE = longitude
    }
    
    func setLongitude(_ longitude: Double) {
        setLongitude(String(longitude))
    }
    
    // onsuccess , onerror , sets up a failure// success block
    func getWeatherData(onSuccess: @escaping (Result) -> Void, onError: @escaping (String) -> Void) {
        // guard to check for valid built URL Dtring before proceeding
        guard let url = URL(string: buildURL()) else {
            onError("Error building URL")
            return
        }
        
        let task = session.dataTask(with: url) { (data, response, error) in
            
            //  Schedule the code contained within the closure to run on the main dispatch queue in an asynchronous manner
            //  Error To Resolve: Main Thread Checker: UI API called on a background thread:
            // Make API HTTP Request
            //https://www.raywenderlic.com/3244963-urlsession-tutorial-getting-started
            
            DispatchQueue.main.async {
                guard let data = data, let response = response as? HTTPURLResponse else {
                    onError("Invalid data or response")
                    return
                }
                do {
                    // if 200 code then convert to swift Codeaable struct (Model)
                    if response.statusCode == 200 {
                        let items = try JSONDecoder().decode(Result.self, from: data)
                        onSuccess(items)
                    } else {
                        onError("\(response.statusCode)")
                    }
                } catch {
                    onError(error.localizedDescription)
                }
            }
            
        }
        task.resume()
    }
    
}
