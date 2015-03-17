//
//  MemeTableViewController.swift
//  MemeMe
//
//  Created by Andrew Bell on 3/14/15.
//  Copyright (c) 2015 FiixedMobile. All rights reserved.
//

import UIKit

class MemeTableViewController: UITableViewController {
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem (
            title: "Add",
            style: UIBarButtonItemStyle.Plain,
            target: self,
            action: "loadMemeEditor"
        )
        
        self.navigationItem.title = "Memes"
        
//        if (UIApplication.sharedApplication().delegate as AppDelegate).memes.count == 0 {
//            self.loadMemeEditor()
//        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
      
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return (UIApplication.sharedApplication().delegate as AppDelegate).memes.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell
        
        // Configure the cell...
        
        let meme = (UIApplication.sharedApplication().delegate as AppDelegate).memes[indexPath.row]
        
        // Set the text and image
        cell.textLabel?.text = meme.topText
        cell.imageView?.image = meme.memeImage
        cell.detailTextLabel?.text = meme.bottomText
       
        
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController")! as MemeDetailViewController
        detailController.meme = (UIApplication.sharedApplication().delegate as AppDelegate).memes[indexPath.row]
        self.navigationController!.pushViewController(detailController, animated: true)
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the specified item to be editable.
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
    // Return NO if you do not want the item to be re-orderable.
    return true
    }
    */
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Helper methods
    
    func loadMemeEditor() {
        var mevc:MemeEditorViewController
        mevc = self.storyboard?.instantiateViewControllerWithIdentifier("MemeEditorViewController") as MemeEditorViewController
        
        presentViewController(mevc, animated: true, completion: nil)
    }
    
    
    
}
