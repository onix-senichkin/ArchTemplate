//
//  ProfileVC.swift
//  ArchitectureTemplate
//
//  Created by Denis Senichkin on 10/24/18.
//  Copyright © 2018 Denis Senichkin. All rights reserved.
//

import UIKit
import MapKit

class ProfileVC: UITableViewController {
    
    var viewModel: ProfileViewModelType!
    
    @IBOutlet weak var lbNameTitle: UILabel!
    @IBOutlet weak var lbEmailTitle: UILabel!
    @IBOutlet weak var lbAddressTitle: UILabel!
    @IBOutlet weak var lbLogoutTitle: UILabel!
    
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbEmail: UILabel!
    @IBOutlet weak var lbAddress: UILabel!
    @IBOutlet weak var ivMapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        localize()
    }
    
    deinit {
        print("ProfileVC - deinit")
    }
    
    private func setupUI() {
        tableView.tableFooterView = UIView()
        lbName.text = viewModel.getUserName()
        lbEmail.text = viewModel.getUserEmail()
        lbAddress.text = viewModel.getUserAddress()
        ivMapView.showsUserLocation = true
        ivMapView.userTrackingMode = .follow
        
        viewModel.getUserAddress { [weak self] address in
            self?.lbAddress.text = address
        }
    }
    
    private func localize() {
        self.title = "Profile.Title".localized
        lbNameTitle.text = "Profile.Name".localized + ":"
        lbEmailTitle.text = "RegistrationCell.Email".localized + ":"
        lbAddressTitle.text = "RegistrationCell.Address".localized + ":"
        lbLogoutTitle.text = "Profile.Logout".localized
    }
}

//MARK:- UITableViewDelegate
extension ProfileVC {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == ProfileCells.logout.rawValue {
            viewModel.logout()
        }
    }
}
