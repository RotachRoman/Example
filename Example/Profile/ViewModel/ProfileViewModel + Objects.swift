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
}
