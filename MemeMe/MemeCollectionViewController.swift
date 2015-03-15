//
//  MemeCollectionViewController.swift
//  MemeMe
//
//  Created by Andrew Bell on 3/14/15.
//  Copyright (c) 2015 FiixedMobile. All rights reserved.
//

import UIKit

class MemeCollectionViewController: UICollectionViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem (
            title: "Add",
            style: UIBarButtonItemStyle.Plain,
            target: self,
            action: "loadMemeEditor"
        )
        
        
        
        self.navigationItem.title = "Memes"
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (UIApplication.sharedApplication().delegate as AppDelegate).memes.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MemeCollectionViewCell", forIndexPath: indexPath) as MemeCollectionViewCell
        let meme = (UIApplication.sharedApplication().delegate as AppDelegate).memes[indexPath.row]
        
        // Set the text and image
        cell.topTextLabel.text = meme.topText
        cell.bottomTextLabel.text = meme.bottomText
        cell.memeImageView.image = meme.memeImage
        
        
        return cell
    }
    
//    override func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
//        <#code#>
//    }
    
    // MARK: - Helper methods
    
    func loadMemeEditor() {
        var mevc:MemeEditorViewController
        mevc = self.storyboard?.instantiateViewControllerWithIdentifier("MemeEditorViewController") as MemeEditorViewController
        
        presentViewController(mevc, animated: true, completion: nil)
    }

}
