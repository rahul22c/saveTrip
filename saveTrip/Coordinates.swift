//
//  Coordinates.swift
//  saveTrip
//
//  Created by Rahul Chandrawanshi on 8/15/16.
//  Copyright © 2016 Rahul Chandrawanshi. All rights reserved.
//

import Foundation

class Coordinates
{
    //MARK Properties
    
    var longitude:Double! = 1000
    
    var latitude :Double! = 1000
    
    var place:String! = "unknown"
    
    
    
    //MARK Initialization
    
    init ( longitude:Double! , latitude:Double!,place:String!)
    {
       self.longitude = longitude
        self.latitude = latitude
        self.place = place
    }
}