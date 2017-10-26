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
    lazy   var searchBar:UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 350, height: 10))// searchbar
    
    
    var link = "http://api.openweathermap.org/data/2.5/group?id=4880731,5000598,5128581,5368361,4887398,5391811,4930956,1275339,1273294,1275004,1264527,524901,703448,2643743,1816670,292223&units=metric&APPID=ea2cc999e9e272185de78f08e2e738fc"
    //Array of Weather Object
    var weatherInfo = [Weather]() //original object array
    var searchName = [Weather]() // filterd array after search
    var myIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadImages()
        myTableView.delegate = self
        myTableView.dataSource = self
        
        // for searchbar
        searchBar.placeholder = "Search For Beer"
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        let leftNavBarButton = UIBarButtonItem(customView:searchBar)
        self.navigationItem.leftBarButtonItem = leftNavBarButton
        
    }
    
    //for sending data of array countryName into other WIcontroller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let DVC = segue.destination as! WIviewContoller
        DVC.weatherInfo = searchName[myIndex]
    }
    
    
    
    //function for fetching the data from given Api
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
                    
                    self.weatherInfo.append(weatherObj)
                    
                }
                
                self.searchName.append(contentsOf: self.weatherInfo)
                DispatchQueue.main.async() {
                    self.myTableView.reloadData()
                }
                
        }
        
    }
    
    //Tabel view methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryName", for: indexPath)
        
        let country: Weather
        country = searchName[indexPath.row]
        cell.textLabel?.text = country.countryName
        return cell
    }
    //selecting on a cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = indexPath.row
        performSegue(withIdentifier: "WeatherInfo", sender: self)
    }
    
}
//function related to search bar
extension CountryNameViewController: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        
        return true
    }
    
    func isSubstring(s: String) -> Bool {
        
        return s.range(of:searchBar.text!) != nil
        //&& (s.index(of: Character(s1!))  == s.index(of: s.characters.first!))
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            searchName.removeAll()
            searchName.append(contentsOf: weatherInfo)
            myTableView.reloadData()
            return
        }
        self.filterContentForSearchText(searchText)
        self.myTableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
       
        self.filterContentForSearchText(searchBar.text!)
        self.myTableView.reloadData()
        self.searchBar.resignFirstResponder()
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        searchName = weatherInfo.filter({( weatherObj : Weather) -> Bool in
            return (weatherObj.countryName?.lowercased().contains(searchText.lowercased()))!
        })
        
        myTableView.reloadData()
    }
    
    //for cancel button
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchName = weatherInfo
        searchBar.text = nil
        self.myTableView.reloadData()
        self.searchBar.resignFirstResponder()
    }
}



