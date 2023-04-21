//
//  ProfileViewModel.swift
//  leonardo
//
//  Created by Rotach Roman on 22.07.2022.
//

import Foundation

final class ProfileViewModel {
    
    //MARK:  Properties
    private var signResponse: AuthResponse?
    private var profileDataResponse: ProfileResponse?
    private(set) var profileResponse: ProfileMenuResponse?
    private(set) var countries: [CountryResponse] = []
    private(set) var keyAuth: Bool = UserDefaultsManager.auth_status
    
    var output: ((Output) -> Void)?
    
    public var objects: [Section] = []
    
    //MARK: - LifyCicle
    func viewDidAppear() {
        updateStatusAuth()
        fetchProfileMenu()
    }
    
    //MARK: Button func
    func likeBarBtnT(){
        ProfileRouting.pushFavouriteVC() {[weak self] vc in
            self?.output?(.push(vc))
        }
    }
    
    func bellBarBtnT() {
        ProfileRouting.pushNotify(){[weak self] vc in
            self?.output?(.push(vc))
        }
    }
}

extension ProfileViewModel {
    private func updateProfileData(){
        if let index = objects.firstIndex(where: {$0.type == .card}) {
            guard var cell = objects[index].items.first as? Cell else {
                return
            }
            cell.title = (profileDataResponse?.name ?? "") + " " + (profileDataResponse?.surname ?? "")
            cell.url = profileDataResponse?.avaImg
            objects[index].items[0] = cell
            self.output?(.reloadData)
        }
    }
}

//MARK: - View Logic
extension ProfileViewModel {
    func didSelectRowAt(section: Int, row: Int){
        //Пререход на Routing (удалил)
    }
}

//MARK: Logic
extension ProfileViewModel {
    
    private func logOutChangeAuthStatus() {
        UserDefaultsManager.auth_status = false
        self.keyAuth = false
        fetchProfileMenu()
    }
}

//MARK: - Supporting funcs
extension ProfileViewModel{
    func updateStatusAuth(){
        self.keyAuth = UserDefaultsManager.auth_status
        fetchInitData()
    }
    
    func showDeleteAccountAlert() {
        //Пререход на Routing (удалил)
    }
}

//MARK: Netw
extension ProfileViewModel {
    
    //MARK: Log out
    private func logOut(){
        self.output?(.animating(true))
        
        SignService.shared.logOut { [weak self] result in
            self?.output?(.animating(false))
            
            switch result {
            case .success(let response):
                self?.signResponse = response
                self?.successLogOut()
            case .failure(let error):
                print(error.localizedDescription)
                self?.output?(.presentError("Ошибка с загрузкой"))
            }
        }
    }
    
    private func removeUser(){
        self.output?(.animating(true))
        
        SignService.shared.removeUser { [weak self] result in
            self?.output?(.animating(false))
            
            switch result {
            case .success(_):
                UserDefaultsManager.removeAll()
                self?.restartApplication()
            case .failure(let error):
                print(error.localizedDescription)
                self?.output?(.presentError("Ошибка с загрузкой"))
            }
        }
    }
    
    func restartApplication() {
        let viewController = Routing.shared.getViewControllerForPush(storyboard: .ChooseAuthentication)
        guard
            let window = UIApplication.shared.keyWindow,
            let rootViewController = window.rootViewController
        else {
            return
        }
        
        viewController.view.frame = rootViewController.view.frame
        viewController.view.layoutIfNeeded()
        
        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
            window.rootViewController = viewController
        })
    }
}

//MARK: Success
extension ProfileViewModel {
    
    private func successLogOut(){
        if signResponse?.success == true {
            self.logOutChangeAuthStatus()
        } else {
            output?(.presentError(signResponse?.data?.errors?[0] ?? "Ошибка"))
        }
    }
}
