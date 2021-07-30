//
//  MainScreenPresenter.swift
//  RealmApplication
//
//  Created by Evgeniy Chernyshov on 21.07.2021.
//

//po Realm.Configuration.defaultConfiguration.fileURL

import Foundation
import RealmSwift

protocol MainScreenPresenterDelegate: AnyObject {
    func showActivityIndicator()
    func hideActivityIndicator()
    func onUpdateView()
}

class MainScreenPresenter: MainScreenPresenterProtocol {
    
    let storage: RealmServiceProtocol = RealmService()
    
    typealias PresenterDelegate = MainScreenPresenterDelegate & UIViewController
    
    weak var delegate: PresenterDelegate?
    
    let service = RealmService()
    
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
    
    func fetchSomeData() {
        let myDog = Wallet()
        myDog.type = "Rex"
        myDog.id = 1
        print("name of dog: \(myDog.type)")

        // Get the default Realm
        let realm = try! Realm()

        // Query Realm for all dogs less than 2 years old
        let puppies = realm.objects(Wallet.self).filter("id < 2")
        puppies.count // => 0 because no dogs have been added to the Realm yet

        // Persist your data easily
//        try! realm.write {
//            realm.add(myDog)
//        }
//
        // Queries are updated in realtime
        puppies.count // => 1

        // Query and update from any thread
        DispatchQueue(label: "background").async {
            autoreleasepool {
                let realm = try! Realm()
                let theDog = realm.objects(Wallet.self).filter("type == Rex").first
                try! realm.write {
                    theDog!.type = "Rich"
                }
            }
    }
    }
    
    func removeData() {
        //let wallet = Wallet()
        service.removeAll()
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
        //myWallet.type = stringData
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
