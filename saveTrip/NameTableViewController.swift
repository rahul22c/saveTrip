//
//  NameTableViewController.swift
//  saveTrip
//
//  Created by Rahul Chandrawanshi on 8/16/16.
//  Copyright © 2016 Rahul Chandrawanshi. All rights reserved.
//

import UIKit

class NameTableViewController: UITableViewController, UISearchBarDelegate{
    
    var sampledatas = [Sampledata]()
    var filtereddata = [Sampledata]()
    var filteredname = [String]()
    var searchActive : Bool = false
     var data = [String]()

    @IBOutlet weak var Searchbar: UISearchBar!
    
    
    func loadsample(){
    let photo1 = UIImage(named: "Trip")
        let data1 = Sampledata(name:"gokarna",tripname: "bangalore" ,photo: photo1, place: " karnataka" )
        
        let data2 = Sampledata(name:"goa",tripname: "pune" ,photo: photo1, place: "Goa " )
        
        
        let data3 = Sampledata(name:"nainital",tripname: "family trip" ,photo: photo1, place: "Nanital" )
        
        let data4 = Sampledata(name:"hyderabad",tripname: "family trip" ,photo: photo1, place: "hyderabad" )
        
        let data5 = Sampledata(name:"rishikesh",tripname: "college trip" ,photo: photo1, place: "uttrakhand" )
        
        
        sampledatas += [data1,data2,data3,data4,data5]
    
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadsample()
        Searchbar.delegate = self
        
        
        var i:Int = 0
        
        
        while(i < self.sampledatas.count){
            //print(i)
            self.data += [self.sampledatas[i].name]
            
            i += 1
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:Searchbar controller
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
       
        var i:Int = 0
        var j:Int = 0
        self.filtereddata.removeAll()
        self.filteredname.removeAll()
    
        self.filteredname = data.filter({ (text) -> Bool in
            let tmp: NSString = text
            let range = tmp.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            return range.location != NSNotFound
        })
        print(self.filteredname)
        if(self.filteredname.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        
        
        
        while ( i < self.filteredname.count)
        {   while( j < self.sampledatas.count)
            {
            if(self.sampledatas[j].name == self.filteredname[i])
                
            {  self.filtereddata += [self.sampledatas[j]]
                j += 1
                break
            }
                j += 1
            
            }
            
            i += 1

        }
        i=0
        j=0
        
        self.tableView.reloadData()
        print(self.filtereddata)
            }

        
        
        
        
        
        
        
        
        
        
        
        

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(sampledatas.count)
        // #warning Incomplete implementation, return the number of rows
        if(searchActive) {
            return filteredname.count
        }
        return sampledatas.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       
        
        let cell = tableView.dequeueReusableCellWithIdentifier("NamedataTableViewCell", forIndexPath: indexPath) as! NamedataTableViewCell
        

        // Configure the cell...
          if (searchActive && indexPath.row < filteredname.count)
          {  let samplecell = self.filtereddata[indexPath.row]
            cell.Name.text = samplecell.name
            cell.Place.text = samplecell.place
            cell.Tripname.text = samplecell.tripname
            cell.Tripimage.image = samplecell.photo

            
        }
          else{
          let samplecell = self.sampledatas[indexPath.row]
            cell.Name.text = samplecell.name
            cell.Place.text = samplecell.place
            cell.Tripname.text = samplecell.tripname
            cell.Tripimage.image = samplecell.photo
        }
        

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
