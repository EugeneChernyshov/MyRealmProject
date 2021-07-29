//
//  MainScreenViewController.swift
//  RealmApplication
//
//  Created by Evgeniy Chernyshov on 21.07.2021.
//

import UIKit
import RealmSwift

class MainScreenViewController: UIViewController {

   private let presenter = MainScreenPresenter()
    
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    
    @IBOutlet weak var refreshButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setViewDelegate(delegate: self)
        updateView()
    }

    func updateView() {
        self.label.text = self.presenter.getGenresData()
        self.secondLabel.text = self.presenter.getWalletTypesData()
    }
    
    @IBAction func refreshButton(_ sender: UIButton) {
        updateView()
    }
}

extension MainScreenViewController: MainScreenPresenterDelegate {
    func showActivityIndicator() {
        activityView.isHidden = false
        activityView.startAnimating()
    }
    
    func hideActivityIndicator() {
        activityView.isHidden = true
        activityView.stopAnimating()
    }

    func onUpdateView() {
        updateView()
    }
}


