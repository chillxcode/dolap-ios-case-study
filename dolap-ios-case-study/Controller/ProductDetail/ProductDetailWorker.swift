//
//  ProductDetailWorker.swift
//  dolap-ios-case-study
//
//  Created by Emre Çelik on 5.11.2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

class ProductDetailWorker {
    
    func getProduct(onSuccess: @escaping(FileManagerResponse<Product>) -> Void,
                    onError: @escaping(FileManagerError) -> Void) {
        let manager = FileManager()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            manager.get(filePath: .product) { (response: FileManagerResponse<Product>) in
                onSuccess(response)
            } onError: { (error) in
                onError(error)
            }
        }
    }
    
    func getSocial(onSuccess: @escaping(FileManagerResponse<Social>) -> Void,
                    onError: @escaping(FileManagerError) -> Void) {
        let manager = FileManager()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            manager.get(filePath: .social) { (response: FileManagerResponse<Social>) in
                onSuccess(response)
            } onError: { (error) in
                onError(error)
            }
        }
    }
    
}
