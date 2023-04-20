//
//  SocialIconCVC.swift
//  Example
//
//  Created by Rotach Roman on 20.04.2023.
//

import UIKit
import Kingfisher

final class SocialIconCVC: UICollectionViewCell,  CollectionViewCellConfigurable, NibReusable {
    @IBOutlet private weak var imageView: UIImageView!
    
    func configure(with object: CellObject) {
        guard let obj = object as? ProfileViewModel.SocialCell else { return }
        imageView.getImage(urlStr: obj.icon)
    }
}
