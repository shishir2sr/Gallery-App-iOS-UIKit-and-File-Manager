
import Foundation
import UIKit
struct NavigationConfig{
    
    func configRightBarButtons(imageID: String, target: ViewController, action: Selector?) -> UIBarButtonItem{
        return UIBarButtonItem(image: UIImage(systemName: imageID)?.withTintColor(.darkGray, renderingMode: .alwaysOriginal), style: .plain, target: target, action: action)
    }
    
    func navTitle(title: String) -> UILabel{
        let navTitle = UILabel()
        navTitle.textColor = UIColor.darkGray
        navTitle.text = title
        navTitle.font = UIFont(name: "HelveticaNeue-Bold", size: 22.0)!
        return navTitle
    }
    
}
