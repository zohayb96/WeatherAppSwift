//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Zohayb Shaikh on 7/8/21.
//


import UIKit
import MapKit

class WeatherViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var WeatherAppView: WeatherAppView!
    
    var city = ""
    var country = ""
    var weatherResult: Result?
    var locationManger: CLLocationManager!
    var currentlocation: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getLocation()
        
        // Gradient Background
        let topColor = UIColor(red: 117/255, green: 218/255, blue: 255/255, alpha: 0.1)
        let midColor = UIColor(red: 117/255, green: 218/255, blue: 255/255, alpha: 0.5)
        let bottomColor = UIColor(red: 0/255, green: 171/255, blue: 240/255, alpha: 1)
        
        let gradientColors: [CGColor] = [topColor.cgColor, midColor.cgColor ,bottomColor.cgColor]
        let gradientLocations: [Float] = [0.0, 0.5]
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations as [NSNumber]?
        
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }

    
    func getWeatherDataFromAPI() {
        WeatherAPI.shared.getWeatherData(onSuccess: { (result) in
            self.weatherResult = result
            
            self.updateViews()
            
        }) { (errorMessage) in
            debugPrint(errorMessage)
        }
    }
    
    func updateViews() {
        guard let weatherResult = weatherResult else {
            return
        }
        
        WeatherAppView.updateView(currentWeather: weatherResult.current, city: city, country: country)
    }
    
    
    func getLocation() {
       
        if (CLLocationManager.locationServicesEnabled()) {
            locationManger = CLLocationManager()
            locationManger.delegate = self
            locationManger.desiredAccuracy = kCLLocationAccuracyBest
            locationManger.requestWhenInUseAuthorization()
            locationManger.requestLocation()
        }
        
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            self.currentlocation = location
            
            let latitude: Double = self.currentlocation!.coordinate.latitude
            let longitude: Double = self.currentlocation!.coordinate.longitude
            
            WeatherAPI.shared.setLatitude(latitude)
            WeatherAPI.shared.setLongitude(longitude)
            
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
                if let error = error {
                    print(error)
                }
                if let placemarks = placemarks {
                    if placemarks.count > 0 {
                        let placemark = placemarks[0]
                        if let city = placemark.locality {
                            self.city = city
                        }
                        if let country = placemark.country {
                            self.country = country
                        }
                    }
                }
            }
            
            getWeatherDataFromAPI()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        debugPrint(error.localizedDescription)
    }
    
    @IBAction func getWeatherTapped(_ sender: UIButton) {
        getLocation()
    }
    
}
