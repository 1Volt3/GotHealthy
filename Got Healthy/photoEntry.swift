//
//  photoEntry.swift
//  Got Healthy
//
//  Created by Josh Rosenzweig on 3/6/17.
//  Copyright © 2017 Volt. All rights reserved.
//

import UIKit
import MobileCoreServices

class PhotoEntry: UIViewController,UIImagePickerControllerDelegate,
UINavigationControllerDelegate  {
    
    @IBOutlet weak var profilePhotoEntry: UIImageView!
    let picker = UIImagePickerController()
    let profileDefaults = UserDefaults.standard

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        UIApplication.shared.statusBarStyle = .lightContent
        picker.delegate = self
        if let imgData = profileDefaults.object(forKey: "imageChosen") as? NSData
        {
            if let image = UIImage(data: imgData as Data)
            {
                //set image in UIImageView imgSignature
                profilePhotoEntry.image = image
            }
        }
        profilePhotoEntry.layer.borderWidth = 3
        profilePhotoEntry.layer.borderColor = UIColor.white.cgColor
        profilePhotoEntry.layer.cornerRadius = 10.0
        profilePhotoEntry.clipsToBounds = true
    }
    
    @IBAction func gotHealthyPressed(_ sender: Any) {
        let imgData = UIImageJPEGRepresentation(profilePhotoEntry.image!, 1)
        profileDefaults.set(imgData, forKey: "imageChosen")
    }
    
    @IBAction func photoFromLibraryPressed(_ sender: Any) {
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        picker.mediaTypes = [kUTTypeImage as String]
        picker.modalPresentationStyle = .popover
        present(picker, animated: true, completion: nil)
    }
    
    @IBAction func capturePhotoPressed(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.allowsEditing = false
            picker.sourceType = UIImagePickerControllerSourceType.camera
            picker.cameraCaptureMode = .photo
            picker.mediaTypes = [kUTTypeImage as String]
            picker.modalPresentationStyle = .fullScreen
            present(picker,animated: true,completion: nil)
        } else {
            noCamera()
        }
    }
    
    internal func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info: [String : Any])
    {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage 
        profilePhotoEntry.contentMode = .scaleToFill
        profilePhotoEntry.image = chosenImage
        let imgData = UIImageJPEGRepresentation(profilePhotoEntry.image!, 1)
        profileDefaults.set(imgData, forKey: "imageChosen")
        dismiss(animated:true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    func noCamera(){
        let alertVC = UIAlertController(
            title: "No Camera",
            message: "Sorry, this device has no camera",
            preferredStyle: .alert)
        let okAction = UIAlertAction(
            title: "OK",
            style:.default,
            handler: nil)
        alertVC.addAction(okAction)
        present(
            alertVC,
            animated: true,
            completion: nil)
    }
}
