//
//  Date Extension.swift
//  WeatherApp
//
//  Created by Zohayb Shaikh on 7/8/21.
//

import UIKit

extension Date {
    
    static func getTodaysDate() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = .full
        return dateFormatter.string(from: date)
    }
    
}
