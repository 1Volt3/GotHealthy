//
//  photoEntry.swift
//  Got Healthy
//
//  Created by Josh Rosenzweig on 3/6/17.
//  Copyright © 2017 Volt. All rights reserved.
//

import UIKit

class PhotoEntry: UIViewController,UIImagePickerControllerDelegate,
UINavigationControllerDelegate  {
    
    @IBOutlet weak var profilePhotoEntry: UIImageView!
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        UIApplication.shared.statusBarStyle = .lightContent
        picker.delegate = self
        profilePhotoEntry.layer.cornerRadius = profilePhotoEntry.frame.size.width / 2
        profilePhotoEntry.layer.borderWidth = 3
        profilePhotoEntry.layer.borderColor = UIColor.white.cgColor
        profilePhotoEntry.clipsToBounds = true
    }
    
    @IBAction func photoFromLibraryPressed(_ sender: Any) {
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        picker.modalPresentationStyle = .popover
        present(picker, animated: true, completion: nil)
    }
    
    @IBAction func capturePhotoPressed(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.allowsEditing = true
            picker.sourceType = UIImagePickerControllerSourceType.camera
            picker.cameraCaptureMode = .photo
            picker.modalPresentationStyle = .fullScreen
            present(picker,animated: true,completion: nil)
        } else {
            noCamera()
        }
    }
    
    internal func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info: [String : Any])
    {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage 
        profilePhotoEntry.contentMode = .scaleAspectFit
        profilePhotoEntry.image = chosenImage
        dismiss(animated:true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
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
