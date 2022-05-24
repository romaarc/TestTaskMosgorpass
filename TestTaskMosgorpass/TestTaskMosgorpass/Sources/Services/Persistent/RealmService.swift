//
//  RealmService.swift
//  TestTaskMosgorpass
//
//  Created by Roman Gorshkov on 24.05.2022.
//

import Foundation
import RealmSwift

final class RealmService {
    
    let realm = try! Realm()
    
    func saveObject<T: Object>(_ object: T) {
        do {
            if realm.objects(T.self).isEmpty {
                try realm.write {
                    realm.add(object)
                }
            }
        } catch {
            print(RealmServiceErrors.objectSavingError)
        }
    }
    
    func deleteObjects<T: Object>(type: T.Type) {
        do {
            try realm.write {
                realm.deleteAll()
            }
        } catch {
            print(RealmServiceErrors.objectsDeletingError)
        }
    }
    
    func fetchObjects<T: Object>(objectType: T.Type) -> [T]? {
        return Array(realm.objects(T.self))
    }
}

enum RealmServiceErrors: Error {
    case objectSavingError
    case objectsDeletingError
}

