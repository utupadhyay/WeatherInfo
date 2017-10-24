//
//  CountryNameViewController.swift
//  WeatherInfo
//
//  Created by Utkarsh Upadhyay on 23/10/17.
//  Copyright © 2017 Utkarsh Upadhyay. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CountryNameViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var myTableView: UITableView!
    
    var link = "http://api.openweathermap.org/data/2.5/group?id=4880731,5000598,5128581,5368361,4887398,5391811,4930956,1275339,1273294,1275004,1264527,524901,703448,2643743,1816670,292223&units=metric&APPID=ea2cc999e9e272185de78f08e2e738fc"
    var countryName = [Weather]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadImages()
        myTableView.delegate = self
        myTableView.dataSource = self
    }
    
    func loadImages() {
        
        Alamofire.request(link)
            .validate()
            .responseJSON { (response) in
                
                guard response.result.isSuccess else {
                    print("Error with response: \(String(describing: response.result.error))")
                    return
                }
                
                guard let dict = response.result.value as? Dictionary <String,AnyObject> else {
                    print("Error with dictionary: \(String(describing: response.result.error))")
                    return
                }
                
                guard let dictData = dict["list"] as? [Dictionary <String,AnyObject>] else {
                    print("Error with dictionary data: \(String(describing: response.result.error))")
                    return
                }
                
                for data in dictData {
                    
                    guard let countryName: String = data["name"] as? String else {
                        continue
                        
                    }
                    let weatherObj = Weather(countryName: countryName)
                    
                    if let main = data["main"] {
                        if let temp = main["temp"]  as? Float{
                            weatherObj.temp = temp
                        }
                    }
                    
                    if let main = data["main"] {
                        if let temp_min = main["temp_min"]  as? Float{
                            weatherObj.temp_min = temp_min
                        }
                    }
                    
                    if let main = data["main"] {
                        if let temp_max = main["temp_max"]  as? Float{
                            weatherObj.temp_max = temp_max
                        }
                    }
                    
                    if let weather: NSArray = data["weather"] as AnyObject! as? NSArray  {
                        let weatherDict: NSDictionary = weather[0] as! NSDictionary
                        if let description = weatherDict["description"]  as? String{
                            weatherObj.weather_description = description
                        }
                    }
                    
                    if let weather: NSArray = data["weather"] as AnyObject! as? NSArray  {
                        let weatherDict: NSDictionary = weather[0] as! NSDictionary
                        if let main = weatherDict["main"]  as? String{
                            weatherObj.main_weather = main
                        }
                    }
                    
                    self.countryName.append(weatherObj)
                    
                }
                
                self.myTableView.reloadData()
        }
    }
    
    //Tabel view methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryName", for: indexPath)
        let country: Weather = countryName[indexPath.row]
        cell.textLabel?.text = country.countryName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "WeatherInfo", sender: self)
    }
    
}
