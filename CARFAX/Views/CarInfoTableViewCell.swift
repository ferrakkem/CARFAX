//
//  CarInfoTableViewCell.swift
//  CARFAX
//
//  Created by Ferrakkem Bhuiyan on 2020-08-30.
//  Copyright © 2020 Ferrakkem Bhuiyan. All rights reserved.
//

import UIKit

class CarInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var carMakeInfoLabel: UILabel!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var pictureView: UIImageView!
    @IBOutlet weak var carUsesInfoLabel: UILabel!
    @IBOutlet weak var dealerNumberLabel: UILabel!
    @IBOutlet weak var dealerNumberbtn: UIButton!
    
    var cellDelegate: ButtonCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func cinfigureCell(picture: String, carMakeInfo: String, carUsesInfo: String, dealerNumber: String) {
        DispatchQueue.global().async { [weak self] in
            let url = URL(string: picture)
            if url != nil{
                if let data = try? Data(contentsOf: url!) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.pictureView?.image = image
                        }
                    }
                }
            }else{
                DispatchQueue.main.async {
                     self?.pictureView?.image = UIImage.init(named: "noPicture.png")
                }
            }
        }
    
        //pictureView.image = picture
        carMakeInfoLabel.text = carMakeInfo
        carUsesInfoLabel.text = carUsesInfo
        
        dealerNumberbtn.setTitle(dealerNumber, for: .normal)
        
        
        cardView.layer.shadowColor = UIColor.gray.cgColor
        cardView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        cardView.layer.shadowOpacity = 1.0
        cardView.layer.masksToBounds = false
        cardView.layer.cornerRadius = 2.0
        
        dealerNumberLabel.layer.shadowOpacity = 1.0
        
        
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
    cellDelegate?.didPressButton(sender.tag)
    }
    
    
}
