//
//  ModelData.swift
//  HammerStudioTZ
//
//  Created by Максим Палёхин on 31.01.2021.
//

import Foundation
import UIKit
import Realm
import RealmSwift

struct data:Codable {
    var result:Array<autoParsing>
}

struct autoParsing:Codable{
    var name: String
    var description: String
    var icon: String
    var price: String
    var number: String
}

class Auto{
    var name: String
    var description: String
    var icon: UIImage?
    var price: String
    var number: String

    init(autoData:autoParsing) {
        self.name=autoData.name
        self.description=autoData.description
        let url = NSURL(string:  autoData.icon)
        let data = try? Data(contentsOf: url! as URL)
        self.icon=UIImage(data: data!)
        self.price=autoData.price
        self.number = autoData.number
    }
    init(name:String, description: String, icon: UIImage?, price: String, number: String) {
        self.name = name
        self.description = description
        self.price = price
        self.icon = icon
        self.number = number
    }
    init(carFromCache:AutoForCache) {
        self.name = carFromCache.carName
        self.description = carFromCache.carDescription
        self.price = carFromCache.carPrice
        self.number = carFromCache.carNumber
        self.icon = UIImage(data: carFromCache.carIcon as Data)
    }
    
}

class AutoForCache: Object {
    @objc dynamic var carName = "test"
    @objc dynamic var carDescription = "test"
    @objc dynamic var carIcon = NSData(data: UIImage(named: "23")!.jpegData(compressionQuality: 100)!)
    @objc dynamic var carPrice = "test"
    @objc dynamic var carNumber = "test"

    convenience init(name: String, description: String, icon: UIImage?, price: String, number: String) {
        self.init()
        self.carName = name
        self.carDescription = description
        self.carIcon = NSData(data: icon!.jpegData(compressionQuality: 100)!)
        self.carPrice = price
        self.carNumber = number
    }
    
    convenience init(car:Auto) {
        self.init()
        self.carName = car.name
        self.carDescription = car.description
        self.carIcon = NSData(data: car.icon!.jpegData(compressionQuality: 100)!)
        self.carPrice = car.price
        self.carNumber = car.number
    }

}
