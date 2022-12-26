

import UIKit

class DownloadsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var myDownloads: [DownloadsDataClass] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        readAllFilesFromDirectory()
        tableView.reloadData()
    }
    
    // Read files from directory
    func readAllFilesFromDirectory() {
        
            let filePath = getDownloadDirectory()
            if let files = try? FileManager.default.contentsOfDirectory(atPath: filePath.path) {
                myDownloads.removeAll()
                // loop through the files
                for file in files {
                    let imageURL = filePath.appendingPathComponent(file)
                    let imageName = file
                    
                    if  let image =  UIImage(contentsOfFile: imageURL.path){
                
                        myDownloads.append(DownloadsDataClass(imageNameText: imageName, downloadedImage: image))
                    }
                }
            }
        
        tableView.reloadData()
        
        }
    
    func getDownloadDirectory()-> URL{
           // get the file path
           let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
           let documentsDirectory = paths[0]
           let folderURL = documentsDirectory.appendingPathComponent("images")
           print(folderURL.path)
           return folderURL
       }
    
    
    
}

extension DownloadsViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myDownloads.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableviewcell", for: indexPath) as! DownloadsTableViewCell
        let image = myDownloads[indexPath.row]
        
        cell.imageName.text = image.imageNameText
        cell.tableViewImage.image = image.downloadedImage
        
        cell.tableViewImage.layer.borderColor = UIColor.white.cgColor
        cell.tableViewImage.layer.borderWidth = 1
        
        return cell
        
    }
    
    
}


