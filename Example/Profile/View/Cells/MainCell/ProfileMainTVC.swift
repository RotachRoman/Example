//
//  ProfileFirstTVC.swift
//  leonardo
//
//  Created by Rotach Roman on 22.07.2022.
//

import UIKit

final class ProfileMainTVC: UITableViewCell , TableViewCellConfigurable {
    
    //MARK: Properties
    @IBOutlet private weak var iconLbl: UIImageView!
    @IBOutlet private weak var offerLbl: UILabel!
    @IBOutlet private weak var vectorLbl: UIImageView!
    
    //MARK: Configure
    func configure(with object: CellObject) {
        guard let obj = object as? ProfileModel.Cell else { return }
        if let image = obj.imageList {
            iconLbl.getImage(urlStr: image)
            self.iconLbl.isHidden = false
        } else {
            self.iconLbl.isHidden = true
        }
        
        self.offerLbl.setAttribute(with: obj.title, fontName: .SFProDisplayRegular, size: 16, numberOfLines: 1)
    }
}
