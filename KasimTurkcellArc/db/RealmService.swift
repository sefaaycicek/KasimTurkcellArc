//
//  RealmService.swift
//  KasimTurkcellArc
//
//  Created by Sefa Aycicek on 7.11.2024.
//

import UIKit
import Realm
import RealmSwift

protocol RealmServiceProtocol {
    func getAllNotes() -> [NoteUIModel]
    func insertNote(_ note: NoteUIModel)
    func deleteNote(_ note: NoteUIModel)
}

class RealmService : RealmServiceProtocol {
    
    lazy var realm: Realm? = {
        let configure = Realm.Configuration(schemaVersion: 1)
        return try? Realm(configuration: configure)
    }()
    
    func getAllNotes() -> [NoteUIModel] {
        var noteList = [NoteUIModel]()
        realm?.objects(NoteEntity.self).forEach { noteEntity in
            noteList.append(NoteUIModel(note: noteEntity))
        }
        return noteList
    }
    
    func insertNote(_ note: NoteUIModel) {
        do {
            try realm?.write {
                var noteEntity = NoteEntity()
                noteEntity.title = note.noteTitle
                noteEntity.content = note.noteContent
                noteEntity.date = note.noteDate
                noteEntity.isFavorite = note.isFavorite
                realm?.add(noteEntity)
            }
        }  catch {
        
        }
    }
    
    func deleteNote(_ note: NoteUIModel) {
        
    }
}
