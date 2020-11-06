//
//  IFileManager.swift
//  dolap-ios-case-study
//
//  Created by Emre Çelik on 6.11.2020.
//

import Foundation

protocol IFileManager {
    func get<T: Codable>(filePath: FilePath, onSuccess: @escaping Success<T>, onError: @escaping Error)
}
