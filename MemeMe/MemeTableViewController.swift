//
//  MemeTableViewController.swift
//  MemeMe
//
//  Created by Andrew Bell on 3/14/15.
//  Copyright (c) 2015 FiixedMobile. All rights reserved.
//

import UIKit

class MemeTableViewController: UITableViewController {
    
    // MARK: - View Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add right button on nav bar to go to MemeEditor
        self.navigationItem.rightBarButtonItem = UIBarButtonItem (
            title: "Add",
            style: UIBarButtonItemStyle.Plain,
            target: self,
            action: "loadMemeEditor"
        )
        
        self.navigationItem.title = "Memes"
        
        // If Meme array count is empty, load the meme editor
        if (UIApplication.sharedApplication().delegate as AppDelegate).memes.count == 0 {
            self.loadMemeEditor()
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Unhide the toolbar if coming back from detailView
        self.tabBarController?.tabBar.hidden = false
        
        // Increase the row height to 140
        self.tableView.rowHeight = 140.0
        
        // Reload table data when coming from another view
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
    
    // MARK: - UITableViewDelegate method
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController")! as MemeDetailViewController
        detailController.meme = (UIApplication.sharedApplication().delegate as AppDelegate).memes[indexPath.row]
        // Open detailViewController
        self.navigationController!.pushViewController(detailController, animated: true)
    }
    
    
    // MARK: - Helper methods
    
    func loadMemeEditor() {
        var mevc:MemeEditorViewController
        mevc = self.storyboard?.instantiateViewControllerWithIdentifier("MemeEditorViewController") as MemeEditorViewController
        
        presentViewController(mevc, animated: true, completion: nil)
    }
    
    
    
}
