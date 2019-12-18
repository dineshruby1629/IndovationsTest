//
//  PostCell.swift
//  IndovationsTest
//
//  Created by dinesh chandra on 18/12/19.
//  Copyright © 2019 Indovations. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet weak var titleLBL: UILabel!
    @IBOutlet weak var dateLBL: UILabel!
    @IBOutlet weak var postSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureingPostData(_ post : PostObjects)  {
        
        self.titleLBL?.text = post.title
          
        self.dateLBL?.text = Utility.dateformatter(post.created_at)
       
    }
    
}
