//
//  NoteEntity.swift
//  KasimTurkcellArc
//
//  Created by Sefa Aycicek on 7.11.2024.
//

import UIKit
import Realm
import RealmSwift

class NoteEntity: Object {
    @Persisted(primaryKey: true) var identifier : ObjectId
    @Persisted(indexed: true) var title : String = ""
    @Persisted var content : String = ""
    @Persisted var date : Date = Date()
    @Persisted var isFavorite : Bool = false
    @Persisted var isRead : Bool = false
    @Persisted var isDeleted : Bool = false
    
    override class func primaryKey() -> String? {
        return "identifier"
    }
}

class NoteUIModel {
    var identifier : ObjectId
    var noteTitle : String = ""
    var noteContent : String = ""
    var noteDate = Date()
    var isFavorite : Bool = false
    
    init(identifier: ObjectId, noteTitle: String, noteContent: String, noteDate: Date = Date(), isFavorite: Bool) {
        self.identifier = identifier
        self.noteTitle = noteTitle
        self.noteContent = noteContent
        self.noteDate = noteDate
        self.isFavorite = isFavorite
    }
    
    init (note: NoteEntity) {
        self.identifier = note.identifier
        self.noteTitle = note.title
        self.noteContent = note.content
        self.noteDate = note.date
        self.isFavorite = note.isFavorite
    }
    
}
