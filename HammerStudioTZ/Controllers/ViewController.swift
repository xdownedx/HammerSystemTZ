//
//  ViewController.swift
//  HammerStudioTZ
//
//  Created by Максим Палёхин on 31.01.2021.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var collectionView: UICollectionView?
    var autoView = AboutCar()
    let realm = try! Realm()
    var carInCache: Results<AutoForCache>!
    var i = 0
    var parsingData = ParsingData()
    var auto = Array<Auto>()
    
    fileprivate func setupCollectionView() {
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height), collectionViewLayout: UICollectionViewFlowLayout())
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.backgroundColor = #colorLiteral(red: 0.01282197796, green: 0.1087761, blue: 0.1728679836, alpha: 1)
        collectionView?.register(UINib(nibName: "AutoCell", bundle: nil), forCellWithReuseIdentifier: "CellID")
        view.addSubview(collectionView!)
        collectionView?.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        collectionView?.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        collectionView?.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        collectionView?.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        if CheckInternet.isConnectedToNetwork(){
            self.parsingData.onCompletion = {autoInfo in
                self.broadcastData(data: autoInfo)
            }
            self.parsingData.broadcastData()
        }else{
            broadcastDataFromCache()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return auto.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellID", for: indexPath) as! AutoCell
        cell.layer.cornerRadius = 5
        cell.autoImage.image = auto[indexPath.row].icon
        cell.autoName.text = auto[indexPath.row].name
        cell.autoPrice.text = auto[indexPath.row].price
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Int(view.bounds.width)-40, height: 400)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        i=indexPath.row
        self.performSegue(withIdentifier: "AboutCarSegue", sender: self)
    }
    func broadcastData(data:Array<Auto>) {
        
        carInCache = realm.objects(AutoForCache.self)
        auto=data
        if carInCache.isEmpty{
            for car in data{
                storageManager.saveObject(AutoForCache(car: car))
            }
        }else{
            for carCache in carInCache{
                storageManager.deleteObject(carCache)
            }
            for car in data{
                storageManager.saveObject(AutoForCache(car: car))
            }
        }
        collectionView?.reloadData()
    }
    
    func broadcastDataFromCache(){
        
        carInCache = realm.objects(AutoForCache.self)
        for car in carInCache!{
            auto.append(Auto(carFromCache: car))
        }
        collectionView?.reloadData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let carVC:AboutCar = segue.destination as! AboutCar
        carVC.carInfo = auto[i]
        carVC.autoDescription?.text = auto[i].description
        carVC.autoImage?.image = auto[i].icon!
        carVC.autoName?.text = auto[i].name
        carVC.autoPrice?.text = auto[i].price
    }
}

