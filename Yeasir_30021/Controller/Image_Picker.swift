import PhotosUI
import Foundation
import UIKit

struct PickImage{
    
    var changeImagePicker = true
    
    mutating func pickeImageFiles(delegate: ViewController){
        if changeImagePicker{
            let controller = pickPHPImage(delegate: delegate)
            delegate.present(controller, animated: true,completion: nil)
            changeImagePicker = !changeImagePicker
        }else{
            let controller = pickImageUsingImagePicker(delegate: delegate)
            delegate.present(controller, animated: true,completion: nil)
            changeImagePicker = !changeImagePicker
        }
    }
    
    func pickPHPImage(delegate: PHPickerViewControllerDelegate) -> PHPickerViewController{
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
