//
//  FileManager.swift
//  dolap-ios-case-study
//
//  Created by Emre Çelik on 5.11.2020.
//

import Foundation

typealias Success<T : Codable> = (FileManagerResponse<T>) -> Void
typealias Error = (FileManagerError) -> Void

class FileManager {
    
    func get<T: Codable>(filePath: FilePath,
                         onSuccess: @escaping Success<T>,
                         onError: @escaping Error) {
        let decoder = JSONDecoder()
        
        guard let url = Bundle.main.url(forResource: filePath.rawValue, withExtension: "json") else {
            onError(.notFound); return
        }
        guard let data = try? Data(contentsOf: url) else {
            onError(.fileNotReadable); return
        }
        guard let model = try? decoder.decode(T.self as T.Type, from: data) else {
            onError(.fileDecode); return
        }
        onSuccess(FileManagerResponse.init(model: model, message: ""))
    }
    
}
