//
//  EnterDataViewController.swift
//  saveTrip
//
//  Created by Rahul Chandrawanshi on 8/13/16.
//  Copyright © 2016 Rahul Chandrawanshi. All rights reserved.
//

import UIKit

class EnterDataViewController: UIViewController , UITextFieldDelegate , UIImagePickerControllerDelegate,UINavigationControllerDelegate {

  
    
    
    // MARK: Prpperties
    
    var dataTrip: DataTrip?
    var coordinates: Coordinates!      // used to get values acquired in main view controller
    var tempname: String!
    var temptripname:String!
    var selectedImage : UIImage! // image for actionsheet view control
    
    var finalimage = UIImage(named: "Trip") // image to save in datatrip after save is clicked in actionsheetview controller
    
    @IBOutlet weak var NameField: UITextField!
    
    @IBOutlet weak var Tripname: UITextField!
    
    @IBOutlet weak var placeLable: UILabel!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    
    //MARK Initialization
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
    
        saveButton.enabled = false
        
        NameField.delegate = self
        Tripname.delegate = self
        
        self.placeLable.text = coordinates.place
        
        
    

        // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    // MARK: UITextFieldDelegate
    
    func textFieldDidBeginEditing(textField: UITextField) {
        // Disable the Save button while editing.
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // hides keyboard
        
        textField.resignFirstResponder()
        return true
        
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        
        switch(textField)
            
        {case NameField :
                tempname = textField.text
        case Tripname:
                temptripname = textField.text!
                saveButton.enabled = true               // enables savebutton
        default:
               print("error")
        }
        
        
    }
    
    
    
    
    // MARK: UIImagePickerControllerDelegate
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        
        // Dismiss the picker if the user canceled.
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        
        // The info dictionary contains multiple representations of the image, and this uses the original.
         selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        // Set photoImageView to display the selected image.
       // photoImageView.image = selectedImage
        
        // Dismiss the picker.
        dismissViewControllerAnimated(true, completion: nil)
        self.performSegueWithIdentifier("imageSegue", sender: nil)

    }
    

    
    
   // MARK: Actions
  
   
    @IBAction func Save(sender: AnyObject) {
    
        // initiates datatrip constructor and saves it in database
        
        // calling main data class to store information
        dataTrip = DataTrip(nameByUser: tempname , tripName: temptripname , place: coordinates.place , latitude : coordinates.latitude , longitude: coordinates.longitude)
        
        
        // saving the information
        
       // saveTrip()
        
        print(dataTrip?.latitude!)
        print(dataTrip?.place)
        print(dataTrip?.longitude)
        print(dataTrip?.tripName)
        print(dataTrip?.nameByUser)

        
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMealMode {
            dismissViewControllerAnimated(true, completion: nil)
        }
        else {
            navigationController!.popViewControllerAnimated(true)
        }
        
    }
    
    
    
    
    @IBAction func OpenActionSheet(sender: AnyObject) {
        
        let actionsheet = UIAlertController(title: "", message: "", preferredStyle: UIAlertControllerStyle.ActionSheet)
        
      
       
        actionsheet.addAction(UIAlertAction(title: "Take Perfect Photo", style: UIAlertActionStyle.Default, handler:{ action in
                    switch action.style{
                    case .Default:
                        self.imagefromlibrary("camera")
                        
                    default:
                        print("error")
            } } ))
        
        actionsheet.addAction(UIAlertAction(title: "Already have a Photo", style: UIAlertActionStyle.Default, handler:{ action in
            switch action.style{
            case .Default:
                self.imagefromlibrary( "gallery")
                
                
                
            default:
                print("error1")
                
                 } } ))
                actionsheet.addAction(UIAlertAction(title: "Add information", style: UIAlertActionStyle.Default, handler:{ action in
                    switch action.style{
                    case .Default:
                        print("addInformation")
                        self.performSegueWithIdentifier("addinformationSegue", sender: nil)
                        
                    default:
                        print("error2")
                    } } ))

        actionsheet.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler:nil))
        self.presentViewController(actionsheet, animated: true, completion: nil)
        

    }
    
    
    
    
    
    
    //MARK : Extras
    
    func saveTrip() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(dataTrip!, toFile: DataTrip.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save meals...")
        }
    }
    
    func imagefromlibrary( send : String)
    {
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        if (send == " gallery")
        {
        imagePickerController.sourceType = .PhotoLibrary
        }
        if (send == "camera")
        {
            imagePickerController.sourceType = .Camera
        }
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        
        dismissViewControllerAnimated(true, completion: nil)
        
      
        self.presentViewController(imagePickerController, animated: true, completion: nil)
       
    
 
       print("imagefromLibrary")
    
    }
    
    
    
    
    // MARK: - Navigation
    
    @IBAction func Cancel(sender: AnyObject) {
        
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMealMode {
            dismissViewControllerAnimated(true, completion: nil)
        }
        else {
            navigationController!.popViewControllerAnimated(true)
        }
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //Get the new view controller using segue.destinationViewController.
        //Pass the selected object to the new view controller.
        if (segue.identifier == "imageSegue"){
            
            let actionsheetimage = segue.destinationViewController as! ActionsheetImageViewController
            
            actionsheetimage.tempimage = selectedImage
        
        
        }
        //Pass the selected object to the new view controller.
        if (segue.identifier == "addinformationSegue")
        {
            
            let addinformation = segue.destinationViewController as! AddInformationViewController
            
             addinformation.tripimage = finalimage

        }
        }
    
     @IBAction func unwindToactionsheet(sender: UIStoryboardSegue) {
         let sourceViewController = sender.sourceViewController as! ActionsheetImageViewController
         finalimage = sourceViewController.tempimage
    }
    
    
    @IBAction func unwindToActionsheetfromAddInformatiom(sender: UIStoryboardSegue) {
        let sourceViewController = sender.sourceViewController as! AddInformationViewController
            print( sourceViewController.information.text)
    }

}



// override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
// Get the new view controller using segue.destinationViewController.
// Pass the selected object to the new view controller.
//  }

/* let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: UIAlertControllerStyle.Alert)
 alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: { action in
 switch action.style{
 case .Default:
 print("default")
 
 case .Cancel:
 print("cancel")
 
 case .Destructive:
 print("destructive")
 }
 }))
 self.presentViewController(alert, animated: true, completion: nil)*/

/*   if coordinates.longitude! == "nil", coordinates.latitude! == "nil"
 {
 let alert = UIAlertController(title: "Alert", message: "Coordinates not acquired , Please try again ", preferredStyle: UIAlertControllerStyle.Alert)
 alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
 }
 else
 {*/
