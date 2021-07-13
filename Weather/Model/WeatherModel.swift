//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Zohayb Shaikh on 7/8/21.
//


import Foundation

// Codeable used to help convert API json data to swift structs using: 
// JSONDecoder.decode()

struct Result: Codable {
    let lat: Double
    let lon: Double
    let timezone: String
    let current: Current
}
    
struct Current: Codable {
    let dt: Int
    let sunrise: Int
    let sunset: Int
    let temp: Double
    let feels_like: Double
    let pressure: Int
    let humidity: Int
    let dew_point: Double
    let uvi: Double
    let clouds: Int
    let wind_speed: Double
    let wind_deg: Int
    let weather: [Weather]
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}


struct Temperature: Codable {
    let day: Double
    let min: Double
    let max: Double
    let night: Double
    let eve: Double
    let morn: Double
}

struct Feels_Like: Codable {
    let day: Double
    let night: Double
    let eve: Double
    let morn: Double
}

// Minutely, Hourly, Daily data not defined from API
