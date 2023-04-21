//
//  ProfileFooterTVC.swift
//  leonardo
//
//  Created by Rotach Roman on 25.07.2022.
//

import UIKit

final class ProfileFooterTVC: UITableViewCell, TableViewCellConfigurable {
    
    //MARK: - Properties
    @IBOutlet private weak var phoneNumber: UIButton!
    @IBOutlet private weak var underPhoneNumber: UILabel!
    @IBOutlet private weak var aboutSeller: UILabel!
    @IBOutlet private weak var deleteAcountButton: UIButton!
    @IBOutlet private weak var collectionView: DynamicHeightCollectionView!
    
    private var objects: [CellObject] = []
    var didTapDelete: (() -> Void)?
    
    let customLayout = CenterFlowLayout(
           itemSize: CGSize(width: 32, height: 32),
           minimumInteritemSpacing: 10,
           minimumLineSpacing: 10,
           sectionInset: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
       )
    
    //MARK: - LifyCicle
    override func layoutSubviews() {
        super.layoutSubviews()
        for view in subviews where view != contentView {
            view.removeFromSuperview()
        }
    }
    override func awakeFromNib() {
            super.awakeFromNib()
            setupCollectionView()
        }
    
    //MARK: - Helper
    public func configure(with object: CellObject) {
        guard let obj = object as? ProfileModel.FooterCell else { return }
        guard let phone = UserDefaultsManager.phone_country else { return }
        self.didTapDelete = obj.didTapDelete
        objects = obj.socials
        self.phoneNumber.setAttribute(with: phone, fontName: .SFProDisplaySemibold, size: 20)
        self.underPhoneNumber.setAttribute(with: "Бесплатно по \(setupCountryDeclination(id: obj.countryId))", fontName: .SFProDisplayRegular, size: 16, alignment: .center)
        self.aboutSeller.setAttribute(with: obj.jurAddress, fontName: .SFProDisplayRegular, size: 14, alignment: .center)
        self.deleteAcountButton.setAttribute(with: "Удалить профиль", fontName: .SFProDisplayRegular, size: 14, color: Colors._E7544D.value)
        setupFonts()
        collectionView.reloadData()
    }
    
    private func setupFonts(){
        phoneNumber.titleLabel?.font = UIFont(name: FontNames.SFProDisplayBold.value, size: 20)
    }
    
    private func setupCountryDeclination(id: String) -> String {
        switch id {
        case "1" : return "России"
        case "2" : return "Беларуссии"
        case "3" : return "Казахстану"
        default: return ""
        }
    }
    
    private func setupCollectionView() {
        collectionView?.collectionViewLayout = customLayout
        collectionView.register(cellType: SociIconCVC.self)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
        collectionView.layoutIfNeeded()
    }
    
    //MARK: - Action
    @IBAction func phoneTapped(_ sender: UIButton) {
        guard let phone = UserDefaultsManager.phone_country else { return }
        phone.openURL(type: .phone)
    }
    
    @IBAction func deleteAcountTapped(_ sender: UIButton) {
        didTapDelete?()
    }
    
}

 //MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension ProfileFooterTVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        objects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: SociIconCVC.self)
        let object = objects[indexPath.row]
        cell.configure(with: object)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cellObject = objects[indexPath.row] as? ProfileModel.SocialCell
        guard let url = cellObject?.url else { return }
        url.openURL(type: .noneType)
    }
}
