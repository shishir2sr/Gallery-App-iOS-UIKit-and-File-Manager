import UIKit
import PhotosUI

class ViewController: UIViewController {
    
    var movieData = [
        UIImage(named: "bmx"),
        UIImage(named: "filmmaker"),
        UIImage(named: "happynewyear"),
        UIImage(named: "jazz"),
        UIImage(named: "rugby"),
        UIImage(named: "inception"),
        UIImage(named: "godzilla"),
        UIImage(named: "joker"),
    ]
    
    var imagePicker = PickImage()
    var changeImagePicker = true
    
    var galleryConfig = GalleryConfiguration()
    
    var fileManagerController = FileManagerController()
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configNavItems()
        configCollectionView()
        collectionView.collectionViewLayout = galleryConfig.listLayoutSection()
        
    }
    
    @IBAction func floatingActionButton(_ sender: UIButton) {
        print("foating action button pressed")
        imagePicker.pickeImageFiles(delegate: self)
    }
    
    
    func configNavItems(){
         // nav buttons
        let listButton = UIBarButtonItem(image: UIImage(systemName: "rectangle.grid.1x2.fill")?.withTintColor(.darkGray, renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(listButtonPressed))
        
        let gridButton = UIBarButtonItem(image: UIImage(systemName: "rectangle.grid.2x2.fill")?.withTintColor(.darkGray, renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(gridButtonPressed))
         
        //nav title
        let navTitle = UILabel()
        navTitle.textColor = UIColor.darkGray
        navTitle.text = "Gallery"
        navTitle.font = UIFont(name: "HelveticaNeue-Bold", size: 22.0)!
        
        //configuration
        self.navigationItem.rightBarButtonItems = [listButton, gridButton]
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: navTitle)
        
    } //config items
    
    @objc func gridButtonPressed() {
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem?.customView?.isUserInteractionEnabled = false
        collectionView.startInteractiveTransition(to: galleryConfig.gridLayoutSection()){ [weak self] _,_ in
            
            guard let self = self else {return}
            self.navigationController?.navigationBar.topItem?.rightBarButtonItem?.customView?.isUserInteractionEnabled = true

        }
        collectionView.finishInteractiveTransition()
        print("grid layout pressed")
        
    }
    
    // list layout
    @objc func listButtonPressed() {

        self.navigationController?.navigationBar.topItem?.rightBarButtonItem?.customView?.isUserInteractionEnabled = false
        
        collectionView.startInteractiveTransition(to: galleryConfig.listLayoutSection()){ [weak self] _,_ in
            guard let self = self else{return}

            self.navigationController?.navigationBar.topItem?.rightBarButtonItem?.customView?.isUserInteractionEnabled = true
        }
        
        collectionView.finishInteractiveTransition()
        print("list layout pressed")
        
    }
    
    private func configCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
    } //config collectionview
    
} //view controller



extension ViewController:UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let image = movieData[indexPath.row]{
            fileManagerController.showActionSheet(image: image, view: self)
        }
        else{
            return
        }
        
        
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
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movieData.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CVCell", for: indexPath) as! CVCell
        cell.imageView.image = movieData[indexPath.row]
        return cell
    }
    
    
} // UicollectionviewDelegate and UICollectionViewDataSource

extension ViewController: PHPickerViewControllerDelegate{
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: nil)
                results.forEach { (result) in
                    result.itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                        if let error = error{
                            print(error.localizedDescription)
                            return
                        }
                        guard let image = image as? UIImage else {return}
                        DispatchQueue.main.async {
                            self.movieData.append(image)
                            self.collectionView.reloadData()
                }
            }
        }
    }
    
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            picker.dismiss(animated: true, completion: nil)
        guard let image = info[.originalImage] as? UIImage else {return}
            movieData.append(image)
            collectionView.reloadData()
        }
    
}

