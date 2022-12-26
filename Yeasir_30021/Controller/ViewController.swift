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
    var configNavigationBar = NavigationConfig()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configNavItems()
        configCollectionView()
        collectionView.collectionViewLayout = galleryConfig.listLayoutSection()
        
    }
    
    @IBAction func floatingActionButton(_ sender: UIButton) {
        imagePicker.pickeImageFiles(delegate: self)
    }
    
    
    func configNavItems(){
         // nav buttons
        let listButton = configNavigationBar.configRightBarButtons(imageID: "rectangle.grid.1x2.fill", target: self, action: #selector(listButtonPressed))
        let gridButton = configNavigationBar.configRightBarButtons(imageID: "rectangle.grid.2x2.fill", target: self, action: #selector(gridButtonPressed))
      
        self.navigationItem.rightBarButtonItems = [listButton, gridButton]
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: configNavigationBar.navTitle(title: "Gallery"))
        
    } //config items
    
    @objc func gridButtonPressed() {
        galleryConfig.performNavButtonAction(to: galleryConfig.gridLayoutSection, view: self, collectionView: self.collectionView)
    }

    // list layout
    @objc func listButtonPressed() {
        galleryConfig.performNavButtonAction(to: galleryConfig.listLayoutSection, view: self, collectionView: self.collectionView)
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

