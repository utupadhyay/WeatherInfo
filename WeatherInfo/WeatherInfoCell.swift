//
//  WeatherInfoCell.swift
//  WeatherInfo
//
//  Created by Utkarsh Upadhyay on 22/10/17.
//  Copyright © 2017 Utkarsh Upadhyay. All rights reserved.
//

import UIKit

class WeatherInfoCell: UICollectionViewCell {
    
    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var temperature: UILabel!

    @IBOutlet weak var maxTemp: UILabel!
    @IBOutlet weak var minTemp: UILabel!
    @IBOutlet weak var weatherMain: UILabel!
    
    @IBOutlet weak var weatherDiscription: UILabel!
    
    @IBOutlet weak var myView: UIImageView!
   
    
}
