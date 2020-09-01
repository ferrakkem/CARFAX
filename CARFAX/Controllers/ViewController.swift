//
//  ViewController.swift
//  CARFAX
//
//  Created by Ferrakkem Bhuiyan on 2020-08-30.
//  Copyright © 2020 Ferrakkem Bhuiyan. All rights reserved.
//

import UIKit
import SkeletonView

class ViewController: UIViewController {
    
    var dataManager = DataManager()
    
    private var carData: CarInfoResponse?
    @IBOutlet weak var carInfoTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.navigationItem.title = "DashBoard"
        
        dataManager.delegate = self
        dataManager.fetechCarInformation()
    
        //MARK: - calling setUpTableView Function
        setupTableView()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        carInfoTable.isSkeletonable = true
        carInfoTable.showAnimatedSkeleton(usingColor: .gray, transition: .crossDissolve(0.200))
    }
    
    //MARK: - Setup or Register UItableView
    func setupTableView() {
        carInfoTable.dataSource = self
        carInfoTable.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellReuseIdentifier)
        carInfoTable.separatorStyle = .none
        carInfoTable.contentInsetAdjustmentBehavior = .never
        carInfoTable .reloadData()
    }
}


//MARK: - UITextFieldDelegate
extension ViewController: SkeletonTableViewDataSource{
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return K.cellReuseIdentifier
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.carData?.listings.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = carInfoTable.dequeueReusableCell(withIdentifier: K.cellReuseIdentifier, for: indexPath) as! CarInfoTableViewCell
        let info = self.carData?.listings[indexPath.row]
        //print(info!)
        
        cell.cellDelegate = self
        cell.dealerNumberLabel.layer.cornerRadius = 5.00
    
        
        if let year = info?.year, let make = info?.make, let model = info?.model, let price = info?.currentPrice, let mileage = info?.mileage, let address = info?.dealer.address, let number = info?.dealer.phone {
            let carMakeInfo = ("\(String(year)) \(make) \(model)")
            let carUsesInfo = ("$\(price) | \(String(mileage)) Mi | \(address)")
            cell.cinfigureCell(picture: info?.images.large[0] ?? "", carMakeInfo: carMakeInfo , carUsesInfo: carUsesInfo, dealerNumber: "Press To Call Dealer:\( number)")
            cell.dealerNumberbtn.tag = Int(number)!
        }
        carInfoTable.allowsSelection = false
        return cell
    }
    
}


//MARK: - CarDataManagerDelegate
extension ViewController: CarDataManagerDelegate{
    func didUpdateData(_ carData: CarInfoResponse) {
        self.carData = carData
        DispatchQueue.main.async {
            self.carInfoTable.stopSkeletonAnimation()
            self.view.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
            self.carInfoTable.reloadData()
        }
    }
    func didFailWithError(error: Error) {
        print(error)
    }
}

//MARK: - Call ButtonDelegate
extension ViewController: ButtonCellDelegate{
    func didPressButton(_ tag: Int) {
        //print(tag)
        if let url = URL(string: "tel://\(tag)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }

}


