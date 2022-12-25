//
//  Image_Picker.swift
//  Yeasir_30021
//
//  Created by Yeasir Arefin Tusher on 25/12/22.
//
import PhotosUI
import Foundation
import UIKit

struct PickImage{
    
   
    
    
    
    func pickImage(delegate: PHPickerViewControllerDelegate) -> PHPickerViewController{
           var picker = PHPickerConfiguration()
           picker.filter = .images
           picker.selectionLimit = 3
           let controller = PHPickerViewController(configuration: picker)
           controller.delegate = delegate
           return controller
       }
    
    
    func pickImageUsingImagePicker(delegate: ViewController) -> UIImagePickerController{
           let picker = UIImagePickerController()
           picker.sourceType = .photoLibrary
           picker.delegate = delegate
           return picker
       }
}
