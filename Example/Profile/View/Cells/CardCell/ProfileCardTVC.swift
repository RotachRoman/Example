//
//  ProfileCardTVC.swift
//  leonardo
//
//  Created by Rotach Roman on 22.07.2022.
//

import UIKit

final class ProfileCardTVC: UITableViewCell, TableViewCellConfigurable {
    
    //MARK: Properties
    @IBOutlet private weak var photoLbl: UIImageView!
    @IBOutlet private weak var nameLbl: UILabel!
    @IBOutlet private weak var vectorLbl: UIImageView!
    
    //MARK: Configure
    func configure(with object: CellObject) {
        guard let obj = object as? ProfileViewModel.Cell else { return }
        if let url = URL(string: obj.url ?? "") {
            self.photoLbl.load(url: url)
        }
        self.nameLbl.setAttribute(with: obj.title, fontName: .SFProDisplayMedium, size: 16)
    }
}
