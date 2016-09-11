//
//  DataTrip.swift
//  saveTrip
//
//  Created by Rahul Chandrawanshi on 8/14/16.
//  Copyright © 2016 Rahul Chandrawanshi. All rights reserved.
//

import UIKit

class DataTrip: NSObject, NSCoding  {
    
    //MARk : Properties

    var nameByUser : String! = "nil"
    
    var tripName : String!
    
    var place :String! = "Unknown"
    
    var latitude: Double!
    
    var longitude: Double!
    
    //var photo: UIImage?
    
    // MARK: Types
    
    
    struct PropertyKey {
        static let namekey = "name"
        static let tripnamekey = "tripname"
        static let placekey = "place"
        static let latitudekey = "latitude"
        static let longitudekey = "longitude"
        static let photokey = "tripimage"
    }

    
    // MARK: NSCoding
    
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(nameByUser, forKey: PropertyKey.namekey)
        aCoder.encodeObject(tripName, forKey: PropertyKey.tripnamekey)
        aCoder.encodeObject(place, forKey: PropertyKey.placekey)
        aCoder.encodeDouble(latitude, forKey: PropertyKey.latitudekey)
        aCoder.encodeDouble(longitude, forKey: PropertyKey.longitudekey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let nameByuser = aDecoder.decodeObjectForKey(PropertyKey.namekey) as! String
        
        // Because photo is an optional property of Meal, use conditional cast.
        let tripname = aDecoder.decodeObjectForKey(PropertyKey.tripnamekey) as? String
        
        let places = aDecoder.decodeObjectForKey(PropertyKey.placekey) as? String
        
        let latitudes = aDecoder.decodeDoubleForKey(PropertyKey.latitudekey)
        
        let longitudes = aDecoder.decodeDoubleForKey(PropertyKey.longitudekey)
        
       // let images = aDecoder.decodeObjectForKey(PropertyKey.photokey) as? UIImage
        
        
        // Must call designated initializer.
        self.init(nameByUser : nameByuser , tripName : tripname! , place :places!, latitude: latitudes , longitude:longitudes )
    }
    
    
    
    // MARK: Archiving Paths
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("Savetrips")
    
    

    
    //MARK: Initialization
    init(nameByUser : String! , tripName : String! , place :String!, latitude: Double! , longitude: Double! )
    {
        self.nameByUser = nameByUser
        self.tripName = tripName
        self.place = place
        self.latitude = latitude
        self.longitude = longitude
        
        

        
    
    
    }
    
    
    
    
    
    
    
}