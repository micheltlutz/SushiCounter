//
//  SushiDayViewModel.swift
//  CoffeeCouter
//
//  Created by Michel Anderson Lutz Teixeira on 24/10/18.
//  Copyright © 2018 Michel Anderson Lutz Teixeira. All rights reserved.
//

import Foundation

import RealmSwift
import RxRealm

final class SushiDayViewModel {
    
    static var shared: sushiDayViewModel = SushiDayViewModel()
    
    private let realm = try! Realm()
    
    private var shushis: Results<sushiDay>?
    
    var didError: ((_ error: String) -> Void)?
    
    var didUpdateCoffee: (() -> Void)?
    
    func persistsushiDay(sushiDay: sushiDay) {
        shushis = realm.objects(sushiDay.self)
        if let filteredSushis = self.shushis?.filter("date = '\(sushiDay.date)'").first {
            //Update sushiDay
            do {
                try realm.write {
                    filteredSushis.count = sushiDay.count
                }
                didUpdateCoffee?()
            } catch {
                print("persistCoffee Error: ", error, filteredSushis)
                didError?(error.localizedDescription)
            }
        } else {
            //New sushiDay
            create(sushiDay: sushiDay)
        }
    }
    
    private func create(sushiDay: sushiDay) {
        do {
            try realm.write {
                realm.add(sushiDay)
            }
            didUpdateCoffee?()
            print("SushiDay Criado com sucesso: ", sushiDay)
        } catch {
            print("Error realm SushiDay \(error)", sushiDay)
            didError?(error.localizedDescription)
        }
    }
    
    func getToday() -> sushiDay? {
        shushis = realm.objects(sushiDay.self)
        guard let filteredSushis = self.shushis?.filter("date = '\(DateUtils.dateNow())'").first else {
            return sushiDay()
        }
        return filteredSushis
    }
    
    func allshushis() -> [sushiDay]? {
        shushis = realm.objects(sushiDay.self)
        
        guard let filteredShushis = self.shushis else {
            return []
        }
        return filteredShushis.toArray()
    }
}
