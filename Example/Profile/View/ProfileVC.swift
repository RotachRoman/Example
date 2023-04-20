//
//  ProfileVC.swift
//  leonardo
//
//  Created by Rotach Roman on 22.07.2022.
//

import UIKit

final class ProfileVC: BaseViewController {

    //MARK: Properties
    @IBOutlet private weak var likeBarBtn: UIBarButtonItem!
    @IBOutlet private weak var bellBarBtn: UIBarButtonItem!
    @IBOutlet private weak var tableView: UITableView!
    
    var viewModel: ProfileViewModel!
    
    //MARK: Life cicle
    override func viewDidLoad(){
        super.viewDidLoad()
        viewModel = ProfileViewModel()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        tabBarController?.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.viewDidAppear()
    }
    
    //MARK: Setup
    func setup(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = UIView()
        tableView.sectionHeaderHeight = 0
        tableView.tableFooterView = UIView()
        tableView.sectionFooterHeight = 0
        configureViewModelBinding()
    }
    
    //MARK: @IBAction
    @IBAction private func barBtnT(_ sender: UIBarButtonItem) {
        switch sender {
        case likeBarBtn:
            viewModel.likeBarBtnT()
        case bellBarBtn:
            viewModel.bellBarBtnT()
        default:
            break
        }
    }
}

//MARK: - Table Delegate&DataSource
extension ProfileVC: UITableViewDelegate&UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.objects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionObject = viewModel.objects[indexPath.section]
        
        var cell: TableViewCellConfigurable!
        
        let cellObject = sectionObject.items[indexPath.row]
        
        switch sectionObject.type {
            
        case .notAuth:
            cell = tableView.cell(forClass: ProfileAuthTVC.self)
        case .card:
            cell = tableView.cell(forClass: ProfileCardTVC.self)
        case .list:
            cell = tableView.cell(forClass: ProfileMainTVC.self)
        case .exit:
            cell = tableView.cell(forClass: ProfileExitTVC.self)
        case .footer:
            cell = tableView.cell(forClass: ProfileFooterTVC.self)
        }
        cell.configure(with: cellObject)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.objects[section].items.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 2:
            return 20
        default:
            return 0
        }
    }
    
    //MARK: didSelectRowAt
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRowAt(section: indexPath.section, row: indexPath.row)
    }
}

//MARK: -ViewModelChangeDelegate -

extension ProfileVC: ViewModelChangeConfigure {
    func configureViewModelBinding() {
        viewModel.output = { [weak self] output in
            switch output {
                
            case .present(let vc):
                self?.navigationController?.present(vc, animated: true)
                
            case .push(let vc):
                self?.navigationController?.pushViewController(vc, animated: true)
                
            case .response:
                self?.animatedReload()
                self?.tableView.reloadData()
                
            case .reloadData:
                self?.tableView.reloadData()
                
            case .presentError(let error):
                self?.presentError(with: error, message: nil)
                
            case .animating(let animated):
                animated ? self?.startLoader() : self?.stopLoader()
            }
        }
    }
}

//MARK: - UITabBarControllerDelegate
extension ProfileVC: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if tabBarController.selectedViewController === viewController {
            self.tableView.setContentOffset(CGPoint.zero, animated: true)
            Vibration.light.vibrate()
        }
        return true
    }
}

