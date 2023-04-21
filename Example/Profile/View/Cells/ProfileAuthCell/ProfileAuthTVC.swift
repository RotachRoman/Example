//
//  ProfileAuthTVC.swift
//  leonardo
//
//  Created by Rotach Roman on 25.07.2022.
//

import UIKit

final class ProfileAuthTVC: UITableViewCell, TableViewCellConfigurable {
    
    //MARK: Properies
    var obj: ProfileModel.Cell!
   
    @IBOutlet private weak var titleLbl: UILabel!
    @IBOutlet private weak var subtitleLbl: UILabel!
    @IBOutlet private weak var authButton: OrangeButton!
    
    override var isSelected: Bool {
        didSet {
            titleLbl.isHidden = isSelected
            subtitleLbl.isHidden = isSelected
            authButton.isHidden = isSelected
        }
    }
    
    //MARK: Configure
    func configure(with object: CellObject) {
        guard let obj = object as? ProfileModel.Cell else { return }
        self.obj = obj
        setupUI(with: obj)
    }
    
    //MARK: Button
    @IBAction private func authBtnT(_ sender: OrangeButton) {
        guard let vc = Routing.shared.getViewControllerForPush(storyboard: .Sign) as? SignVC else { return }
        vc.viewModel = SignViewModel(inputState: .auth, inputMethod: .email, screenTransition: .profile)
        self.obj.output?(.push(vc))
    }
}

//MARK: Setup UI
extension ProfileAuthTVC {
    private func setupUI(with object: CellObject){
        self.titleLbl.setAttribute(with: obj.title, fontName: .SFProDisplaySemibold, size: 20, alignment: .center)
        self.subtitleLbl.setAttribute(with: "Авторизуйтесь и получите полный доступ к приложению", fontName: .SFProDisplayRegular, size: 16, alignment: .center)
        self.authButton.configure(withTitle: "Авторизироваться")
        setupButton()
    }
    
    private func setupButton(){
        authButton.layer.cornerRadius = 8
        authButton.layer.masksToBounds = true
    }
}
