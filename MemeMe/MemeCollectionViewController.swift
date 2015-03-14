//
//  MemeCollectionViewController.swift
//  MemeMe
//
//  Created by Andrew Bell on 3/14/15.
//  Copyright (c) 2015 FiixedMobile. All rights reserved.
//

import UIKit

class MemeCollectionViewController: UICollectionViewController {
    
    
    var memes: [Meme]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let applicationDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        memes = applicationDelegate.memes
    }

}
