//
//  ProfileExitTVC.swift
//  leonardo
//
//  Created by Rotach Roman on 24.07.2022.
//

import UIKit

final class ProfileExitTVC: UITableViewCell, TableViewCellConfigurable {

    //MARK: Properties
    @IBOutlet private weak var iconLbl: UIImageView!
    @IBOutlet private weak var extitLbl: UILabel!
    
    //MARK: Configure
    public func configure(with object: CellObject) {
        guard let obj = object as? ProfileViewModel.Cell else { return }
        self.iconLbl.image = UIImage(named: obj.key)
        self.extitLbl.setAttribute(with: obj.title, fontName: .SFProDisplayRegular, size: 16)
    }
}
