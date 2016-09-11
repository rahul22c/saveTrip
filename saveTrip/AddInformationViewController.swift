//
//  AddInformationViewController.swift
//  saveTrip
//
//  Created by Rahul Chandrawanshi on 8/25/16.
//  Copyright © 2016 Rahul Chandrawanshi. All rights reserved.
//

import UIKit

class AddInformationViewController: UIViewController {
    
    
    //MARK: Properties
    
    @IBOutlet weak var images: UIImageView!
    
    
    @IBOutlet weak var information: UITextView!
    
    var tripimage: UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()
        images.image = tripimage
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    
    // MARK: - Navigation

     @IBAction func Cancel(sender: AnyObject) {
        
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMealMode {
            dismissViewControllerAnimated(true, completion: nil)
            print("dismissViewController")
        }
        else {
            navigationController!.popViewControllerAnimated(true)
        }

     }
    
    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
