//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by Andrew Bell on 3/16/15.
//  Copyright (c) 2015 FiixedMobile. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    
    var meme: Meme!

    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - View Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tabBarController?.tabBar.hidden = true
        self.imageView!.image = meme.memeImage
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem (
            title: "Add",
            style: UIBarButtonItemStyle.Plain,
            target: self,
            action: "loadMemeEditor"
        )
    }
    
    // MARK: - IBAction methods

    @IBAction func deleteMeme(sender: UIBarButtonItem) {
        // Delete the same meme in the memes array that is currently presented onscreen
        if let index = find((UIApplication.sharedApplication().delegate as AppDelegate).memes, meme) {
            (UIApplication.sharedApplication().delegate as AppDelegate).memes.removeAtIndex(index)
            
            // Reload the imageView to show that the meme has been deleted
            self.imageView!.image = nil
        }
    }
    
    // MARK: - Helper methods
    
    func loadMemeEditor() {
        var mevc:MemeEditorViewController
        mevc = self.storyboard?.instantiateViewControllerWithIdentifier("MemeEditorViewController") as MemeEditorViewController
        presentViewController(mevc, animated: true, completion: nil)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
