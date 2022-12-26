
import Foundation
import UIKit

struct GalleryConfiguration{
    func gridLayoutSection() -> UICollectionViewLayout {
               
        let item1 = CollectionVL.createItem(height: .fractionalHeight(1), width: .fractionalWidth(1/2), spacing: 3)

        let horizontalGroup = CollectionVL.createGroup(height: .fractionalHeight(2/9), width: .fractionalWidth(1), alignment: .horizontal, items: [item1,item1])
        
        horizontalGroup.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 3, bottom: 0, trailing: 3)
        
                let section = NSCollectionLayoutSection(group: horizontalGroup)
        section.orthogonalScrollingBehavior = .none
               
    
                return UICollectionViewCompositionalLayout(section: section)
        }
    
 
    func listLayoutSection() -> UICollectionViewLayout {
               
        let item1 = CollectionVL.createItem(height: .fractionalHeight(1), width: .fractionalWidth(1), spacing: 3)

        let group = CollectionVL.createGroup(height: .fractionalHeight(1/2), width: .fractionalWidth(1), alignment: .horizontal, items: [item1,item1])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 3, bottom: 0, trailing: 3)
        
        let section = NSCollectionLayoutSection(group: group)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
}
