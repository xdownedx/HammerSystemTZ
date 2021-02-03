//
//  StorageManager.swift
//  HammerStudioTZ
//
//  Created by Максим Палёхин on 02.02.2021.
//

import RealmSwift

 
public class storageManager {
     

    static func saveObject (_ carForSave: AutoForCache){
        let realm = try! Realm()

        try! realm.write {
            realm.add(carForSave)
        }
    }
    
    static func deleteObject(_ carForSave: AutoForCache){
        let realm = try! Realm()

        try! realm.write {
            realm.delete(carForSave)
        }
    }
}
