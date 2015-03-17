//
//  MemeCollectionViewController.swift
//  MemeMe
//
//  Created by Andrew Bell on 3/14/15.
//  Copyright (c) 2015 FiixedMobile. All rights reserved.
//
import Foundation
import UIKit

class MemeCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    
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
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (UIApplication.sharedApplication().delegate as AppDelegate).memes.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MemeCollectionViewCell", forIndexPath: indexPath) as MemeCollectionViewCell
        let meme = (UIApplication.sharedApplication().delegate as AppDelegate).memes[indexPath.row]
        
        // Set the image
        cell.memeImageView.image = meme.memeImage
        
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath:NSIndexPath)
    {
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController")! as MemeDetailViewController
        detailController.meme = (UIApplication.sharedApplication().delegate as AppDelegate).memes[indexPath.row]
        self.navigationController!.pushViewController(detailController, animated: true)
        
    }
    
    // MARK: - Helper methods
    
    func loadMemeEditor() {
        var mevc:MemeEditorViewController
        mevc = self.storyboard?.instantiateViewControllerWithIdentifier("MemeEditorViewController") as MemeEditorViewController
        
        presentViewController(mevc, animated: true, completion: nil)
    }
    
}
