//
//  PostCellTable.swift
//  KasimTurkcellArc
//
//  Created by Sefa Aycicek on 6.11.2024.
//

import UIKit

class PostCellTable: UITableViewCell {
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postDetailLabel: UILabel!
    
    func configure(postEntity : PostEntity) {
        postTitleLabel.text = postEntity.title
        postDetailLabel.text = postEntity.body
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
