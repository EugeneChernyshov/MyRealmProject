//
//  MainScreenPresenter.swift
//  RealmApplication
//
//  Created by Evgeniy Chernyshov on 21.07.2021.
//

import Foundation
import RealmSwift

protocol MainScreenPresenterDelegate: AnyObject {
    func showActivityIndicator()
    func hideActivityIndicator()
    func updateLabel()
}

class MainScreenPresenter: MainScreenPresenterProtocol {
    
    typealias PresenterDelegate = MainScreenPresenterDelegate & UIViewController
    
    weak var delegate: PresenterDelegate?
    
    public func setViewDelegate(delegate: PresenterDelegate) {
        self.delegate = delegate
    }
    
    private let realm = try! Realm()
    
    func fetchDataFromNetwork()  {
        delegate?.showActivityIndicator()
        let queue = DispatchQueue(label: "com.utility.saveFromNetwork", qos: .utility)
        
        queue.async {
            Networking.shared.getAllGenres() { [weak self] genres in
                self?.saveStringDataToRealm(name: genres.first?.name)
                self?.delegate?.hideActivityIndicator()
            }
        }
    }
    
    func saveStringDataToRealm(name: String?) {
        let myItem = Item()
        
        self.realm.beginWrite()
        myItem.name = name
        self.realm.add(myItem)
        do {
            try self.realm.commitWrite()
        } catch  {
            print("Error , I can't commit write")
        }
        delegate?.updateLabel()
    }
    
    func reciveTextDescriptionFromDB() -> String? {
        fetchDataFromNetwork()
        
        let results = realm.objects(Item.self)
        
        return results.first?.name
    }
}
