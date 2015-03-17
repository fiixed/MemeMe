//
//  MemeEditorViewController.swift
//  MemeMe
//
//  Created by Andrew Bell on 3/12/15.
//  Copyright (c) 2015 FiixedMobile. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate , UITextFieldDelegate{
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var topToolBar: UIToolbar!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    var pickerController:UIImagePickerController!
    var activityViewController:UIActivityViewController?
    
    // MARK: - View Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pickerController = UIImagePickerController()
        
        // Set delegates
        self.topTextField.delegate = self
        self.bottomTextField.delegate = self
        self.pickerController.delegate = self
        
        
        
        // Set textField attributes
        self.topTextField.defaultTextAttributes = self.textAttributes()
        self.topTextField.text = "TOP"
        self.topTextField.textAlignment = .Center
        
        self.bottomTextField.defaultTextAttributes = self.textAttributes()
        self.bottomTextField.text = "BOTTOM"
        self.bottomTextField.textAlignment = .Center
        
        // Share button hidden initially
        self.shareButton.enabled = false
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Check to see if device has camera to enable camera button
        if(!UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)) {
            cameraButton.enabled = false
        }
        
        self.subscribeToKeyboardNotifications()
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.unsubscribeFromKeyboardNotifications()
    }
    
    // MARK: - Camera/Album methods
    @IBAction func pickCamera(sender: UIBarButtonItem) {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            self.pickerController.sourceType = UIImagePickerControllerSourceType.Camera
            self .presentViewController(self.pickerController, animated: true, completion: nil)
        }
    }
    
    @IBAction func pickAlbum(sender: UIBarButtonItem) {
        self.pickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(self.pickerController, animated: true, completion: nil)
    }
    
    // MARK: - UIImagePickerControllerDelegate methods
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.imageView.image = image
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
        self.shareButton.enabled = true
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
    
    // Get the height of the keyboard
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
        // Create meme font
        let memeTextAttributes = [
            NSStrokeColorAttributeName : UIColor.blackColor(),
            NSForegroundColorAttributeName: UIColor.whiteColor(),
            NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName : -3.0
        ]
        return memeTextAttributes
    }
    
    func save() -> UIImage {
        
        let memedImage = self.generateMemedImage()
        // Create the meme and generate a UUID string for each meme struct
        var meme = Meme(uuid: NSUUID().UUIDString, topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: self.imageView.image!, memeImage: memedImage)
        
        // Add it to the memes array on the AppDelegate
        (UIApplication.sharedApplication().delegate as AppDelegate).memes.append(meme)
 
        return memedImage
    }
    
    func generateMemedImage() -> UIImage {
        
        // Hide toolbar and navbar
        self.toolBar.hidden = true
        self.topToolBar.hidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // Unhide toolbar
        self.toolBar.hidden = false
        self.topToolBar.hidden = false
        
        return memedImage
    }
    
    // Navigate the user to the Tab Bar Controller (TableView and CollectionView)
    func navToTabBarController() {
        var tbc:UITabBarController
        tbc = self.storyboard?.instantiateViewControllerWithIdentifier("TabBarController") as UITabBarController
        
        presentViewController(tbc, animated: true, completion: nil)
    }
    
    // MARK: - IBAction methods
    
    @IBAction func share(sender: UIBarButtonItem) {
        let memedImage = self.save()
        
        // Send memedImage to the ActivityViewController
        let avc = UIActivityViewController(activityItems: [memedImage] , applicationActivities: nil)
        
        // When finished, go to the tab bar controller
        avc.completionWithItemsHandler = {
            (s: String!, ok: Bool, items: [AnyObject]!, err:NSError!) -> Void in
            self.navToTabBarController()
        }
        presentViewController(avc, animated: true, completion: nil)
    }
    
    @IBAction func done(sender: UIBarButtonItem) {
        self.navToTabBarController()
    }
}

