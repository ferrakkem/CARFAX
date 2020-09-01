//
//  DataManager.swift
//  CARFAX
//
//  Created by Ferrakkem Bhuiyan on 2020-08-30.
//  Copyright © 2020 Ferrakkem Bhuiyan. All rights reserved.
//

import Foundation

protocol CarDataManagerDelegate {
    func didUpdateData(_ carData: CarInfoResponse)
    func didFailWithError(error: Error)
}

protocol ButtonCellDelegate : class {
    func didPressButton(_ tag: Int)
}

struct DataManager{
    var delegate:CarDataManagerDelegate?
    
    //MARK: - Fetch Car information
    func fetechCarInformation(){
        let urlString = "https://carfax-for-consumers.firebaseio.com/assignment.json"
        performRequest(with: urlString)
    }
    
    //MARK: - Perform API Request From carfax-for-consumers
    func performRequest(with urlString: String){
        // create a URL
        if let url = URL(string: urlString){
            
            // create url session
            let session = URLSession(configuration: .default)
            
            // Give the session task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil{
                    //print(error!)
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data{
                    self.parseJSON(carData: safeData)
                }
            }
            // start task
            task.resume()
        }
    }
    
    //MARK: - jSON parse
    func parseJSON(carData: Data){
        let decoder = JSONDecoder()
        
        do {
            let dataFromJson = try decoder.decode(CarInfoResponse.self, from: carData)
            self.delegate?.didUpdateData(dataFromJson)
        } catch {
            delegate?.didFailWithError(error: error)
        }
         
    }
}
