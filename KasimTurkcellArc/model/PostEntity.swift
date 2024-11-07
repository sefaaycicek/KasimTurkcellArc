//
//  PostEntity.swift
//  KasimTurkcellArc
//
//  Created by Sefa Aycicek on 6.11.2024.
//

import UIKit

struct PostEntity : Codable {
    let postId : Int
    let userId : Int
    let title : String
    let body : String
    
    enum CodingKeys: String, CodingKey {
        case postId = "id"
        case userId
        case title
        case body
    }
}
