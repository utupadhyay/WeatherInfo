//
//  ViewController.swift
//  WeatherInfo
//
//  Created by Utkarsh Upadhyay on 18/10/17.
//  Copyright © 2017 Utkarsh Upadhyay. All rights reserved.
//

import UIKit


class WIviewContoller: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var weatherCollection: UICollectionView!
    
    var weatherInfo: Weather?
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: 100.0, height: 100.0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherCollection.delegate = self
        weatherCollection.dataSource = self
        
    }
    
    
   
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherInfoCell", for: indexPath) as! WeatherInfoCell
        cell.clipsToBounds = true
        cell.layer.cornerRadius = 4.0
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1.0
        let weather: Weather = weatherInfo!
        cell.countryName!.text = weather.countryName
        cell.weatherDiscription!.text = weather.weather_description
        cell.weatherMain!.text = weather.main_weather
        //add backgroud pic
        if(weather.main_weather == "Clouds"){
            cell.myView!.image = #imageLiteral(resourceName: "clouds")
        }
        if(weather.main_weather == "Rain"){
            cell.myView!.image = #imageLiteral(resourceName: "rain")
        }
        if(weather.main_weather == "Snow"){
            cell.myView!.image = #imageLiteral(resourceName: "snow")
        }
        
        if(weather.main_weather == "Fog" || weather.main_weather == "Smoke"){
            cell.myView!.image = #imageLiteral(resourceName: "smoke")
        }
        if(weather.main_weather == "Clear"){
            cell.myView!.image = #imageLiteral(resourceName: "clearsky")
        }
        if(weather.main_weather == "Haze" || weather.main_weather == "Mist"){
            cell.myView!.image = #imageLiteral(resourceName: "haze")
        }
        
        cell.temperature.text = "\(weather.temp ?? 0)"
        cell.maxTemp.text  = "\(weather.temp_max ?? 0)"
        cell.minTemp.text  = "\(weather.temp_min ?? 0)"
        return cell
        
        
    }
    
    
}

