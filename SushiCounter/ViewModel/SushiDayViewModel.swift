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
    
    static var shared: SushiDayViewModel = SushiDayViewModel()
    
    private let realm = try! Realm()
    
    private var shushis: Results<SushiDay>?
    
    var didError: ((_ error: String) -> Void)?
    
    var didUpdateSushis: (() -> Void)?
    
    func persistsushiDay(sushiDay: SushiDay) {
        shushis = realm.objects(SushiDay.self)
        if let filteredSushis = self.shushis?.filter("date = '\(sushiDay.date)'").first {
            //Update sushiDay
            do {
                try realm.write {
                    filteredSushis.count = sushiDay.count
                }
                didUpdateSushis?()
            } catch {
                print("persistCoffee Error: ", error, filteredSushis)
                didError?(error.localizedDescription)
            }
        } else {
            //New sushiDay
            create(sushiDay: sushiDay)
        }
    }
    
    private func create(sushiDay: SushiDay) {
        do {
            try realm.write {
                realm.add(sushiDay)
            }
            didUpdateSushis?()
            print("SushiDay Criado com sucesso: ", sushiDay)
        } catch {
            print("Error realm SushiDay \(error)", sushiDay)
            didError?(error.localizedDescription)
        }
    }
    
    func getToday() -> SushiDay? {
        shushis = realm.objects(SushiDay.self)
        guard let filteredSushis = self.shushis?.filter("date = '\(DateUtils.dateNow())'").first else {
            return SushiDay()
        }
        return filteredSushis
    }
    
    func allSushis() -> [SushiDay]? {
        shushis = realm.objects(SushiDay.self)
        
        guard let filteredShushis = self.shushis else {
            return []
        }
        return filteredShushis.toArray()
    }
}
