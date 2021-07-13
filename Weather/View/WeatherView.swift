//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Zohayb Shaikh on 7/8/21.
//


import UIKit

class WeatherAppView: UIView {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    func updateView(currentWeather: Current, city: String, country: String) {
        cityLabel.text = city
        countryLabel.text = country
        dateLabel.text = Date.getTodaysDate()
        weatherLabel.text = currentWeather.weather[0].description.capitalized
        weatherImage.image = UIImage(named: currentWeather.weather[0].icon)
        temperatureLabel.text = String(round(currentWeather.temp)) + " °F"
        
    }

}
