//
//  RowTableViewCell.swift
//  NamazKeeper2
//
//  Created by Apple on 04.07.16.
//  Copyright © 2016 NU. All rights reserved.
//

import UIKit
import SnapKit
class RowTableViewCell: UITableViewCell {

    lazy var userLabel = UILabel()
    
    override init (style: UITableViewCellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier:  reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setup(){
        userLabel.text = "Hello"
        //super.updateConstraints()
        self.contentView.addSubview(userLabel)
        updateConstraints()
    }
    override func updateConstraints() {
        super.updateConstraints()
        userLabel.snp_makeConstraints { (make) in
            make.top.equalTo(self.contentView.snp_top)
            make.left.equalTo(0)
            make.bottom.equalTo(self.contentView.snp_bottom)
            make.width.equalTo(self.contentView.snp_width)
            make.height.equalTo(10)
        }
    }

}
