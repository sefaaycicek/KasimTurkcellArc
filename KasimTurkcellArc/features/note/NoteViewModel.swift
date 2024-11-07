//
//  NoteViewModel.swift
//  KasimTurkcellArc
//
//  Created by Sefa Aycicek on 7.11.2024.
//

import UIKit

class NoteViewModel: NSObject {
    let realmService : RealmServiceProtocol
    
    var notes = [NoteUIModel]()
    
    init(realmService : RealmServiceProtocol = RealmService()) {
        self.realmService = realmService
    }
    
    func insertNote(note : NoteUIModel) {
        realmService.insertNote(note)
    }
    
    func getAllNote() -> [NoteUIModel] {
        self.notes = realmService.getAllNotes()
        return self.notes
    }
    
    var rowCount : Int {
        return notes.count
    }
    
    func getItem(index : Int) -> NoteUIModel {
        return notes[index]
    }
}
