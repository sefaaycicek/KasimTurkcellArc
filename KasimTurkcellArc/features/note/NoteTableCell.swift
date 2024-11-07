//
//  NoteTableCell.swift
//  KasimTurkcellArc
//
//  Created by Sefa Aycicek on 7.11.2024.
//

import UIKit

class NoteTableCell: UITableViewCell {

    @IBOutlet weak var lblNoteTitle: UILabel!
    @IBOutlet weak var lblNoteDetail: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var chIsFavorited: UIButton!
    
    func configure(note: NoteUIModel) {
        chIsFavorited.setImage(#imageLiteral(resourceName: "checkBoxSequareEmpty.pdf"), for: .normal)
        chIsFavorited.setImage(#imageLiteral(resourceName: "checkBoxSequareFilled"), for: .selected)
        
        lblNoteTitle.text = note.noteTitle
        lblNoteDetail.text = note.noteContent
        chIsFavorited.isSelected = note.isFavorite
        lblDate.text = note.noteDate.toString(format: .yearMonthDayTitle)
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
