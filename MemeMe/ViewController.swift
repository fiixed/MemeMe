//
//  ViewController.swift
//  MemeMe
//
//  Created by Andrew Bell on 3/12/15.
//  Copyright (c) 2015 FiixedMobile. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate , UITextFieldDelegate{
    
    @IBOutlet weak var memImageView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    var pickerController:UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        self.topTextField.delegate = self
        self.bottomTextField.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
        self.pickerController = UIImagePickerController()
        self.pickerController.delegate = self
        
        self.topTextField.defaultTextAttributes = self.textAttributes()
        self.topTextField.text = "TOP"
        self.topTextField.textAlignment = .Center
        
        self.bottomTextField.defaultTextAttributes = self.textAttributes()
        self.bottomTextField.text = "BOTTOM"
        self.bottomTextField.textAlignment = .Center
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if(!UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)) {
                cameraButton.enabled = false
        }
        
        self.subscribeToKeyboardNotifications()
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.unsubscribeFromKeyboardNotifications()
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
    
    // Dismiss keyboard when the user click on the view (outside the UITextField).
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    //MARK: - TextFieldDelegate
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if self.topTextField.text == "TOP" {
            self.topTextField.text = ""
        } else if self.bottomTextField.text == "BOTTOM" {
            self.bottomTextField.text = ""
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - Shift Keyboard methods
    
    func keyboardWillShow(notifcation: NSNotification) {
        self.view.frame.origin.y -= getKeyboardHeight(notifcation)
    }
    
    func keyboardWillHide(notifcation: NSNotification) {
        self.view.frame.origin.y += getKeyboardHeight(notifcation)
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    // MARK: - Helper methods
    
    func textAttributes() -> [NSString : AnyObject] {
        let memeTextAttributes = [
            NSStrokeColorAttributeName : UIColor.blackColor(),
            NSForegroundColorAttributeName: UIColor.whiteColor(),
            NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName : 0
        ]
        return memeTextAttributes
    }
    
    
    
    
  
    
}

