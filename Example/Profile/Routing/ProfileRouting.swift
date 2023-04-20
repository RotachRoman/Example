//
//  ProfileRouting.swift
//  leonardo
//
//  Created by Rotach Roman on 22.03.2023.
//

import UIKit

final class ProfileRouting {
    static func pushNotify(output: ((UIViewController) -> ())?) {
        let vc = Routing.shared.getViewControllerForPush(storyboard: .Notify)
        output?(vc)
    }
    
    static func pushAboutApp(output: ((UIViewController) -> ())?) {
        let vc = Routing.shared.getViewControllerForPush(storyboard: .AboutApp)
        output?(vc)
    }
    
    static func pushDiscondCardVC(output: ((UIViewController) -> ())?) {
        guard let vc = Routing.shared.getViewControllerForPush(storyboard: .DiscondCard) as? DiscondCardVC else { return }
        output?(vc)
    }
    
    static func pushOrderVC(keyAuth: Bool, output: ((UIViewController) -> ())?){
        if keyAuth {
            let vc = Routing.shared.getViewControllerForPush(storyboard: .CheckAuthOrders)
            output?(vc)
        } else {
            let vc = Routing.shared.getViewControllerForPush(storyboard: .CheckOrder)
            output?(vc)
        }
    }
    
    static func pushBarcodeScaner(output: ((UIViewController) -> ())?){
        let vc = Routing.shared.getViewControllerForPush(storyboard: .BarcodeScaner)
        output?(vc)
    }
    
    static func pushPrEditVC(output: ((UIViewController) -> ())?){
        let vc = Routing.shared.getViewControllerForPush(storyboard: .ProfileEdit)
        output?(vc)
    }
    
    static func pushFavouriteVC(output: ((UIViewController) -> ())?){
        let vc = Routing.shared.getViewControllerForPush(storyboard: .Favorites)
        output?(vc)
    }
    
    static func pushPrServiceVC(prCells: [PrServiceViewModel.Cell], cellObject: ProfileViewModel.Cell, output: ((UIViewController) -> ())?){
        guard let vc = Routing.shared.getViewControllerForPush(storyboard: .PrService) as? PrServiceVC else {
            return
        }
        
        vc.viewModel = PrServiceViewModel(input: .init(navTitle: cellObject.title, cells: prCells))
        output?(vc)
    }
}
