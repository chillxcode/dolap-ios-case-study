//
//  FileManagerError.swift
//  dolap-ios-case-study
//
//  Created by Emre Çelik on 5.11.2020.
//

import Foundation

enum FileManagerError: Swift.Error {
    case notFound
    case fileNotReadable
    case fileDecode
}
