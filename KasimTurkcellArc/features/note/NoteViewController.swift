//
//  NoteViewController.swift
//  KasimTurkcellArc
//
//  Created by Sefa Aycicek on 7.11.2024.
//

import UIKit
import RealmSwift

class NoteViewController: UIViewController {

    @IBOutlet weak var txtNoteDetail: UITextView!
    @IBOutlet weak var txtNoteTitle: UITextField!
    @IBOutlet weak var txtDate: UITextField!
    @IBOutlet weak var btnFavorite: UIButton!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var datePicker = UIDatePicker()
    
    let viewModel = NoteViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        refreshNotes()
    }
    
    private func setupUI() {
        btnFavorite.setImage(#imageLiteral(resourceName: "checkBoxSequareEmpty.pdf"), for: .normal)
        btnFavorite.setImage(#imageLiteral(resourceName: "checkBoxSequareFilled"), for: .selected)
        
        btnSave.layer.cornerRadius = 8
        btnSave.layer.borderWidth = 1
        btnSave.layer.borderColor = UIColor.red.cgColor
        //UIColor(red: 0.1, green: 0.3, blue: 0.2, alpha: 1.0)
        
        txtDate.inputView = datePicker
        
        datePicker.datePickerMode = .dateAndTime
        datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        
    }
    
    @objc func datePickerValueChanged() {
        txtDate.text = datePicker.date.toString(format: .yearMonthDayTitle)
    }
    
    
    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
        btnFavorite.isSelected = !btnFavorite.isSelected
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        
        self.view.endEditing(true)
        
        let note = NoteUIModel(identifier: ObjectId.generate(),
                               noteTitle: txtNoteTitle.text ?? "",
                               noteContent: txtNoteDetail.text ?? "",
                               noteDate: datePicker.date,
                               isFavorite: btnFavorite.isSelected)
        
        viewModel.insertNote(note: note)
        
        refreshNotes()
    }
    
    func refreshNotes() {
        let list = viewModel.getAllNote()
        self.tableView.reloadData()
    }
}

extension NoteViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteTableCell", for: indexPath) as? NoteTableCell
        let note = viewModel.getItem(index: indexPath.row)
        cell?.configure(note: note)
        
        return cell ?? UITableViewCell()
        
    }
}
