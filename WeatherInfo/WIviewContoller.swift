//
//  ViewController.swift
//  WeatherInfo
//
//  Created by Utkarsh Upadhyay on 18/10/17.
//  Copyright © 2017 Utkarsh Upadhyay. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class WIviewContoller: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var weatherCollection: UICollectionView!
    
    var weatherInfo = [Weather]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherCollection.delegate = self
        weatherCollection.dataSource = self
        
    }
    
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let DVC = segue.destination as! WIviewContoller
        DVC.weatherInfo = weatherInfo
    }
   
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherInfo.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherInfoCell", for: indexPath) as! WeatherInfoCell
        cell.clipsToBounds = true
        cell.layer.cornerRadius = 4.0
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1.0
        return cell
        
    }
    
    
}

