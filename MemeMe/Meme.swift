//
//  Meme.swift
//  MemeMe
//
//  Created by Andrew Bell on 3/14/15.
//  Copyright (c) 2015 FiixedMobile. All rights reserved.
//

import Foundation
import UIKit

struct Meme {
    var uuid: String
    var topText: String
    var bottomText: String
    var originalImage: UIImage
    var memeImage: UIImage
    
    }
    // Conform Meme struct to the Equatable protocol for later comparison in detail view
    extension Meme: Equatable {}
    
    func ==(lhs: Meme, rhs: Meme) -> Bool {
        // Compare the uuid string of two memes
        return lhs.uuid == rhs.uuid 
    }
    

