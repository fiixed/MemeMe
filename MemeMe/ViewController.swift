//
//  ViewController.swift
//  MemeMe
//
//  Created by Andrew Bell on 3/12/15.
//  Copyright (c) 2015 FiixedMobile. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var memImageView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    var pickerController:UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.pickerController = UIImagePickerController()
        self.pickerController.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        
        if(!UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)) {
            cameraButton.enabled = false
        }
    }
    
    @IBAction func pickCamera(sender: UIBarButtonItem) {
       
            self.pickerController.sourceType = UIImagePickerControllerSourceType.Camera
            self .presentViewController(self.pickerController, animated: true, completion: nil)
    }
    
    @IBAction func pickAlbum(sender: UIBarButtonItem) {
        self.pickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(self.pickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.memImageView.image = image
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

