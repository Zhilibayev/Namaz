//
//  ProgressViewCell.swift
//  NamazKeeper2
//
//  Created by Apple on 07.07.16.
//  Copyright © 2016 NU. All rights reserved.
//

import UIKit
import ChameleonFramework
import Cartography
class ProgressViewCell: UITableViewCell {
    
    lazy var box = UIView()
    lazy var length = Double()
    
    @IBOutlet weak var imageOfTime: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var time: UILabel!
       
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setLen(percent: CGFloat){
        box.layer.zPosition = -1
        
        self.addSubview(box)
        box.frame = CGRectMake(0, (self.frame.height - (self.frame.height - 10))/2 , self.frame.width*percent, self.frame.height - 10)

        box.backgroundColor = UIColor( red: CGFloat(192/255.0), green: CGFloat(223/255.0), blue: CGFloat(217/255.0), alpha: CGFloat(1.0) )
        //print(self.frame.width*percent)
    }
    
    func makeZeroLength(){
        box.frame = CGRectMake(0, 0, 0, 50)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
