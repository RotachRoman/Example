//
//  ProfileViewModel + CreateObj.swift
//  leonardo
//
//  Created by Rotach Roman on 22.03.2023.
//

import Foundation

// MARK: - Create tables object
extension ProfileViewModel {
    
    //MARK: GetCell
    func getCells(with section: Int) -> [CellType] {
        if keyAuth {
            switch section {
            case 0:
                return [.card]
            case 1:
                return [.list]
            case 2:
                return [.exit, .footer]
            default:
                return []
            }
        } else {
            return [
                .notAuth,
                .list,
                .footer
            ]
        }
    }
    
    func createTableViewObjects(){
        objects.removeAll()
        
        let countCellsTypes = keyAuth ? [0,1,2] : [0]
        
        countCellsTypes.forEach {
            let cellType = getCells(with: $0)
            createTableViewSection(with: cellType)
        }
    }
    
    //MARK: Create Section
    private func createTableViewSection(with cellTypes: [CellType]){
        
        cellTypes.forEach {
            switch $0 {
            case .list:
                var sectionObj: Section
                sectionObj = Section(items: createListCells(), type: .list)
                self.objects.append(sectionObj)
                
            case .exit, .notAuth, .card:
                var sectionObj: Section
                sectionObj = Section(items: [], type: $0)
                sectionObj.items.append(Cell(
                    key: $0.key,
                    title: $0.title,
                    cells: nil) {[weak self] output in
                        switch output {
                        case .push(let vc):
                            self?.output?(.push(vc))
                        }
                    })
                self.objects.append(sectionObj)
            case .footer:
                var sectionObj: Section
                sectionObj = Section(items: createFooterCell(), type: .footer)
                self.objects.append(sectionObj)
            }
            
        }
    }
    
    //MARK: Create Footer
    private func createFooterCell() -> [CellObject] {
        var cells = [CellObject]()
        
        if let curentCountryId = UserDefaultsManager.user_country?.id {
            let selectCountry = self.countries.first { $0.id == curentCountryId }
            let socials = selectCountry?.social ?? []
            
            let socialsCells = socials.map { SocialCell(isSelected: false, icon: $0.icon, url: $0.url) }
            
            cells.append(FooterCell(isSelected: false,
                                    countryId: selectCountry?.id ?? "",
                                    jurAddress: selectCountry?.jurAddress ?? "",
                                    socials: socialsCells,
                                    didTapDelete: { [weak self] in
                self?.showDeleteAccountAlert()
            }))
        }
        return cells
    }
    
    private func createListCells() -> [Cell] {
        var cells: [Cell] = []
        profileResponse?.data.forEach {
            cells.append(createCell(data: $0))
        }
        return cells
    }
    
    //MARK: Create Cell
    private func createCell(data: ProfileMenuData) -> Cell {
        var moreCell: [Cell]? = []
        
        if let items = data.items, !items.isEmpty {
            moreCell = []
            items.forEach { item in
                moreCell!.append(createCell(data: item))
            }
        } else {
            moreCell = nil
        }
        
        return Cell(
            type: data.type?.rawValue,
            key: data.key,
            url: data.url,
            imageList: data.icon ?? "",
            title: data.title,
            cells: moreCell,
            
            output: {[weak self] output in
                switch output {
                case .push(let vc):
                    self?.output?(.push(vc))
                }
            }
        )
    }
}
