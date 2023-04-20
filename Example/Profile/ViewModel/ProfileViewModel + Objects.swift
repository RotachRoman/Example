//
//  ProfileViewModel + Objects.swift
//  leonardo
//
//  Created by mac on 26.07.2022.
//

import UIKit

extension ProfileViewModel {
    
//    MARK: - Clouseres
    enum Output {
        case present(UIViewController)
        case push(UIViewController)
        case response
        case reloadData
        case presentError(String)
        case animating(Bool)
    }
    
//    MARK: - Types
    enum SectionType {
        case profile
        case main
        case exit
        case aboutFooter
    }
    
    enum CellType {
        case card
        case list
        case exit
        case footer
        case notAuth
        
        var title: String {
            switch self {
            case .card:
                return ""
            case .list:
                return ""
            case .exit:
                return "Выйти"
            case .notAuth:
                return "Вы не авторизированы"
            case .footer:
                return ""
            }
        }
        
        var key: String {
            let startKey = "profile"
            switch self {
            default:
                return startKey + "_" + String(describing: self)
            }
        }
    }
    
//    MARK: - Entities
    struct Section: SectionObject {
        var items: [CellObject]
        var type: CellType
    }
    
    struct FooterCell: CellObject {
        var isSelected: Bool = false
        var countryId: String = ""
        var jurAddress: String = ""
        var socials: [CellObject]
        
        var didTapDelete: (() -> Void)?
    }
    
    struct SocialCell: CellObject {
        var isSelected: Bool = false
        var icon: String = ""
        var url: String = ""
    }
    
    struct Cell: CellObject {
        var isSelected: Bool = false
        var type: String?
        var key: String
        var url: String?
        var imageList: String?
        var title: String
        var cells: [Cell]?
        
        var output: ((Output) -> Void)?
        enum Output {
            case push(UIViewController)
        }
    }
    
    enum KeysScreens: String {
        case order = "order"
        case favorites = "favorites"
        case barcodeScanner = "barcode_scanner"
        case discount = "discount"
        case aboutApp = "about_app"
    }
    
    enum OpenViewType: String {
        case screen = "screen"
        case webview = "webview"
        case items = "items"
    }
}
