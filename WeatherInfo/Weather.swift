//
//  Weather.swift
//  WeatherInfo
//
//  Created by Utkarsh Upadhyay on 18/10/17.
//  Copyright © 2017 Utkarsh Upadhyay. All rights reserved.
//

import UIKit

class Weather: NSObject {

    
    let  countryName: String?
    var  temp: Float?
    var temp_min: Float?
    var temp_max : Float?
    var main_weather : String?
    var weather_description : String?
    
    init(countryName: String) {
       
        self.countryName = countryName
        
    }
    
}

