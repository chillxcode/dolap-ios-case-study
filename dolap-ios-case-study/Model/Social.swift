//
//  Social.swift
//  dolap-ios-case-study
//
//  Created by Emre Çelik on 5.11.2020.
//

import Foundation

struct CommentDetail: Codable {
    let averageRating: Double
    let anonymousCommentsCount: Int
    let memberCommentsCount: Int
}

struct Social: Codable {
    let likeCount: Int
    let commentCounts: CommentDetail
}
