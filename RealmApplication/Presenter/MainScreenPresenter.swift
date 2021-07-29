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
    func onUpdateView()
}

class MainScreenPresenter: MainScreenPresenterProtocol {
    
    typealias PresenterDelegate = MainScreenPresenterDelegate & UIViewController
    
    weak var delegate: PresenterDelegate?
    
    public func setViewDelegate(delegate: PresenterDelegate) {
        self.delegate = delegate
    }
    
    private let realm = try! Realm()
    
    func fetchWalletData() {
        delegate?.showActivityIndicator()
        let queue = DispatchQueue(label: "com.utility.saveFromNetwork", qos: .utility)
        
       queue.async {
            guard let url = URL(string: WalletApi.getFullUrlString(baseURL: WalletApi.BaseUrl, destination: WalletApi.destination)) else { return }
            
            Networking.shared.fetch(from: url, decodable: WalletTypesModel.self) { type in

                self.saveWalletTypesData(stringData: type.walletTypes.first?.name)
                self.delegate?.hideActivityIndicator()
            }
        }
    }
    
    
    func fetchGenresData()  {
        delegate?.showActivityIndicator()
        let queue = DispatchQueue(label: "com.utility.saveFromNetwork", qos: .utility)
        
        queue.async {
            guard let url = URL(string: MovieApi.getFullUrlString(baseURL: MovieApi.BaseUrl, apiKey: MovieApi.apiKey, destination: MovieApi.destination, language: MovieApi.language)) else { return }
             
             Networking.shared.fetch(from: url, decodable: FilmGenresModel.self) { genre in

                self.saveGenresData(stringData: genre.genres.first?.name)
                self.delegate?.hideActivityIndicator()
             }
         }
    }
    
    
    
    func saveWalletTypesData(stringData: String?) {
        let myWallet = Wallet()
        
        self.realm.beginWrite()
        myWallet.type = stringData
        self.realm.add(myWallet)
        do {
            try self.realm.commitWrite()
        } catch  {
            print("Error , I can't commit write")
        }
        delegate?.onUpdateView()
    }
    
    func saveGenresData(stringData: String?) {
        let myItem = Item()
        
        self.realm.beginWrite()
        myItem.name = stringData
        self.realm.add(myItem)
        do {
            try self.realm.commitWrite()
        } catch  {
            print("Error , I can't commit write")
        }
        delegate?.onUpdateView()
    }
    
    func getGenresData() -> String? {
        fetchGenresData()
        
        let results = realm.objects(Item.self)
        
        return results.first?.name
    }
    
    func getWalletTypesData() -> String? {
        fetchWalletData()
        let results = realm.objects(Wallet.self)
        
        return results.first?.type
    }
}
