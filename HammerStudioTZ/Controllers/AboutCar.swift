//
//  AboutCar.swift
//  HammerStudioTZ
//
//  Created by Максим Палёхин on 01.02.2021.
//

import UIKit

class AboutCar: UIViewController {

    @IBOutlet weak var autoImage: UIImageView!
    @IBOutlet weak var autoName: UILabel!
    @IBOutlet weak var autoPrice: UILabel!
    @IBOutlet weak var autoDescription: UILabel!
    @IBOutlet weak var callForHelp: UIButton!
    var carInfo: Auto?
    override func viewDidLoad() {
        super.viewDidLoad()
        autoImage?.image = carInfo!.icon!
        autoName?.text = carInfo!.name
        autoDescription?.text = carInfo!.description
        autoPrice?.text = carInfo!.price
        callForHelp?.layer.cornerRadius = 10
    }
    
    @IBAction func callForHelpAction(_ sender: Any) {
        let url = URL(string: "telprompt://\(carInfo!.number)")!
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
    }
    
}
