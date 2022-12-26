
import UIKit
import Foundation

struct FileManagerController{
    func showActionSheet(image:UIImage, view: ViewController){
         let actionSheet = UIAlertController(title: "Save Image", message: "Do you want to save this image?", preferredStyle: .actionSheet)
         
         actionSheet.addAction(UIAlertAction(title: "Save", style: .default, handler: { (action:UIAlertAction) in
             saveImage(image: image)
         }))
         
         actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
         
         view.present(actionSheet, animated: true, completion: nil)
     }
    
    func saveImage(image: UIImage) {
                let fileManager = FileManager.default
                guard let documentDirURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else{
                    return
                }
          
                let folderURL = documentDirURL.appendingPathComponent("images")
                
                do{
                    try fileManager.createDirectory(at: folderURL, withIntermediateDirectories: true)
                }catch{
                    print(error)
                }
                
                //MARK: Write
                let image = image
                let data = image.pngData()
                let fileURL = folderURL.appendingPathComponent(" image - \(Date.now.formatted(date: .omitted, time: .shortened))")
        print(fileURL.path)
                fileManager.createFile(atPath: fileURL.path, contents: data)
       }
}
