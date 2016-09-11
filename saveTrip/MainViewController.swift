//
//  ViewController.swift
//  saveTrip
//
//  Created by Rahul Chandrawanshi on 8/12/16.
//  Copyright © 2016 Rahul Chandrawanshi. All rights reserved.
//

import UIKit
import CoreLocation

class MainViewController: UIViewController , CLLocationManagerDelegate , UIImagePickerControllerDelegate {
    
    
    //MARK : Properties

   
    @IBOutlet weak var Latitude: UILabel!
    
    
    @IBOutlet weak var Longitude: UILabel!
    
    
    @IBOutlet weak var placeLabel: UILabel!
    
    @IBOutlet weak var Activityindicator: UIActivityIndicatorView!
    
    @IBOutlet weak var AddLocation: UIBarButtonItem!

    
    // MARk : Values
    
    
    var tempcoordinate : Coordinates!
    
    let locationManager = CLLocationManager()
    
    var locValue:CLLocationCoordinate2D!
    
    var place: String! = "Unknown"
    
    
   
    //MARK: Initialization
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Create a location manager object
        self.AddLocation.enabled = false
        
        // Set the delegate
        self.locationManager.delegate = self
        
        self.locationManager.requestWhenInUseAuthorization()
        
        //self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
       
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    

    //MARK :Locationdelegate
    
    
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
        
        
    {   self.AddLocation.enabled = false
        self.Activityindicator.startAnimating()
        self.locValue = manager.location!.coordinate
        
        Latitude.text = String(self.locValue.latitude)
        Longitude.text = String(self.locValue.longitude)
        
        
        CLGeocoder().reverseGeocodeLocation(manager.location!) { (placemarks, ErrorType) -> Void in
            if(ErrorType != nil)
            {
                print("Error: " + ErrorType!.localizedDescription);
                return;
                
                
            }
            
            if(placemarks?.count > 0)
            {
                let pm = placemarks![0] ;
                print(pm.locality);
                print(pm.postalCode);
                print(pm.administrativeArea);
                print(pm.country);
                
                if pm.locality == nil{
                    self.place = "unknown"
                }
                else
                {
                self.place = (pm.locality! + " " + pm.administrativeArea! + " " + pm.country!)
                }
                self.placeLabel.text = self.place
            }
            
          self.tempcoordinate = Coordinates(longitude: self.locValue.longitude, latitude: self.locValue.latitude, place: self.place)
            
          self.locationManager.stopUpdatingLocation()
            
            self.Activityindicator.stopAnimating()
            self.AddLocation.enabled = true
        }
       
      }
    
    
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError)
    {
        print("error" + error.localizedDescription)
        
        
    }
    
    
    
    
    //MARK: Actions
    
    
    @IBAction func AcquireLocation(sender: AnyObject) {
        
        self.locationManager.startUpdatingLocation()
        print("Locationacquire")
    }


    //MARK: Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if ( AddLocation === sender)
        {   let CoordinateData = segue.destinationViewController as! EnterDataViewController
            CoordinateData.coordinates = self.tempcoordinate
                       
            }
        
        if (segue.identifier == "Savedplaces")
        {
            self.locationManager.stopUpdatingLocation() // stop the acquiring process once the user is going to saved places
            
            self.Activityindicator.stopAnimating()
        }
        // Get the new view controller using segue.destinationViewController.
         //Pass the selected object to the new view controller.
          }


}