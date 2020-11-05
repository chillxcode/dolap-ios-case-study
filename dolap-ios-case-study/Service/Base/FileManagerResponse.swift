//
//  FileManagerResponse.swift
//  dolap-ios-case-study
//
//  Created by Emre Çelik on 5.11.2020.
//

import Foundation

struct FileManagerResponse<T : Codable> {
    var model: T?
    var message: String?
}
