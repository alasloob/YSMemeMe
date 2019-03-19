//
//  YSMemeMeViewController.swift
//  YSMeMe
//
//  Created by Youssef Eid on 04/07/1440 AH.
//  Copyright © 1440 Youssef Eid. All rights reserved.
//

import UIKit
import AVFoundation

class YSMemeMeViewController: UIViewController {

    // MARK: TextFiled
    var topText: UITextField!
    var bottomText: UITextField!
    
    // MARK: Outlet Buttons
    @IBOutlet weak var btnCamera: UIBarButtonItem!
    @IBOutlet weak var btnPublishing: UIBarButtonItem!
    
    // MARK: Container Editing Image And ImageView
    @IBOutlet weak var ivImage: UIImageView!
    
    // Text Field Attribetes
    let textFieldAttributes: [NSAttributedString.Key : Any] = [
        NSAttributedString.Key(rawValue: NSAttributedString.Key.strokeColor.rawValue): UIColor.black,
        NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): UIColor.white,
        NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue): UIFont.systemFont(ofSize: 30.0),
        NSAttributedString.Key(rawValue: NSAttributedString.Key.strokeWidth.rawValue): -1
    ]
    
    
    // MARK: View Controller Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.settingTextField()
        self.btnPublishing.isEnabled = false
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//        self.ivImage.translatesAutoresizingMaskIntoConstraints = false
//        if UIDevice.current.orientation.isPortrait {
//            self.ivImage.heightAnchor.constraint(equalTo: self.ivImage.widthAnchor, multiplier: 0.8, constant: 0).isActive = true
//        } else {
//            self.ivImage.heightAnchor.constraint(equalTo: self.ivImage.widthAnchor, multiplier: 1.9, constant: 0).isActive = true
//        }
//        self.ivImage.setNeedsUpdateConstraints()
        print("dddd")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.btnCamera.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        self.subscribeKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.unsubscribeKeyboardNotifications()
    }
    
    fileprivate func settingTextField() {
        self.topText = self.createTextField(txt: "Top")
        self.ivImage.addSubview(self.topText)
        self.topText.autoLayout(top: self.ivImage.topAnchor, bottom: nil,
                                left: self.ivImage.leftAnchor,
                                right: self.ivImage.rightAnchor,
                                marginTop: 24.0,
                                marginBottom: 0,
                                marginLeft: 0,
                                marginRight: 0)
        
        self.bottomText = self.createTextField(txt: "Bottom")
        self.ivImage.addSubview(self.bottomText)
        self.bottomText.autoLayout(top: nil,
                                   bottom: self.ivImage.bottomAnchor,
                                   left: self.ivImage.leftAnchor,
                                   right: self.ivImage.rightAnchor,
                                   marginTop: 0,
                                   marginBottom: -24.0,
                                   marginLeft: 0,
                                   marginRight: 0)
        
        self.textFieldEnabled(isEnabled: false)
    }
    
    // MARK: Create And Setting
    fileprivate func createTextField(txt: String) -> UITextField {
        let txtField = UITextField()
        txtField.translatesAutoresizingMaskIntoConstraints = false
        txtField.delegate = self
        txtField.defaultTextAttributes = textFieldAttributes
        txtField.textAlignment = .center
        txtField.borderStyle = .none
        txtField.textColor = .white
        txtField.text = txt
        return txtField
    }
    
    fileprivate func textFieldEnabled(isEnabled: Bool) {
        self.topText.isEnabled = isEnabled
        self.bottomText.isEnabled = isEnabled
    }
    
    // MARK: Actions Buttons
    @IBAction func importImageFromCameraOrGallery(_ sender: UIBarButtonItem) {
        let imgPicker = UIImagePickerController()
        imgPicker.delegate = self
        imgPicker.allowsEditing = true
        imgPicker.sourceType = sender.tag == 1 ? .camera : .photoLibrary
        if sender.tag == 1 {
            self.permissionCamera(completed: { granted in
                if granted {
                    self.present(imgPicker, animated: true)
                } else {
                    AlertView.show("Error",message: MessageError.camera , vc: self)
                }
            })
        } else {
            self.present(imgPicker, animated: true)
        }
    }

    fileprivate func permissionCamera(completed: @escaping (Bool) -> Void) {
        let cameraMediaType = AVMediaType.video
        let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: cameraMediaType)
        switch cameraAuthorizationStatus {
        case .denied:
            completed(false)
            break
        case .authorized:
            completed(true)
            break
        case .restricted:
            completed(false)
            break
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: cameraMediaType) { granted in
                DispatchQueue.main.async {
                     if granted {
                        completed(true)
                     } else {
                        completed(false)
                    }
                }
            }
        }
    }
    
    @IBAction func publishingImage(_ sender: UIBarButtonItem) {
        let newImage = self.generateNewImage()
        let actvivyVC = UIActivityViewController(activityItems: [newImage], applicationActivities: nil)
        actvivyVC.completionWithItemsHandler = {
            activity, completed, items, error in
            if completed {
                self.saveMemeWhenFinish() // use this function in the version 2.0
                actvivyVC.dismiss(animated: true)
            }
        }
        self.present(actvivyVC, animated: true)
    }
    
    @IBAction func createNewEditor() {
        self.ivImage.image = nil
        self.btnPublishing.isEnabled = false
        self.topText.text = "Top"
        self.bottomText.text = "Bottom"
    }
    
    // MARK: Generate new Image
    fileprivate func generateNewImage() -> UIImage {
        UIGraphicsBeginImageContext(self.ivImage.frame.size)
        self.ivImage.drawHierarchy(in: self.ivImage.bounds, afterScreenUpdates: true)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
    fileprivate func saveMemeWhenFinish() {
        // use this function in the version 2.0
        
//        let meme = YSMeme(topText: self.topText.text!,
//                               bottomText: self.bottomText.text!,
//                               orginalImage: self.ivImage.image!,
//                               editorImage: generateNewImage())
        
    }
    
}

// MARK: Text Field Delegate And Keyboard Notifications
extension YSMemeMeViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text?.trimmingCharacters(in:.whitespaces) == "" {
            if textField == self.topText {
                textField.text = "Top"
            }
            if textField == self.bottomText {
                textField.text = "Bottom"
            }
        }
        textField.resignFirstResponder()
        return true
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        self.ivImage.frame.origin.y = 0 //(UIScreen.main.bounds.height / 2 + self.ivImage.bounds.height / 2
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if self.bottomText.isEditing {
            self.ivImage.frame.origin.y = getKeyboardHeight(notification)
        }
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    func subscribeKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
}

// MARK: Image Picker Controller Deleagate
extension YSMemeMeViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            self.ivImage.image = image
            print("image size \(image.size.height) - \(image.size.width)")
            self.btnPublishing.isEnabled = true
            self.textFieldEnabled(isEnabled: true)
        }
        else if let image = info[.originalImage] as? UIImage {
            self.ivImage.image = image
            self.btnPublishing.isEnabled = true
            self.textFieldEnabled(isEnabled: true)
        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }

}

// MARK: Add Methods Auto Layout
extension UIView {
    
    func autoLayout(top: NSLayoutYAxisAnchor?, bottom: NSLayoutYAxisAnchor?, left:NSLayoutXAxisAnchor?, right: NSLayoutXAxisAnchor?, marginTop: CGFloat, marginBottom: CGFloat, marginLeft: CGFloat, marginRight: CGFloat) {
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: marginTop).isActive = true
        }
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: marginBottom).isActive = true
        }
        if let right = right {
            self.rightAnchor.constraint(equalTo: right, constant: marginRight).isActive = true
        }
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: marginLeft).isActive = true
        }
    }
    
}

extension YSMemeMeViewController: UINavigationControllerDelegate {}
