//
//  ProductDetailModels.swift
//  dolap-ios-case-study
//
//  Created by Emre Çelik on 5.11.2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

enum ProductDetail {
    
    enum GetProduct {
        struct Request {
        }
        
        struct Response {
            var product: FileManagerResponse<Product>?
            var error: FileManagerError?
        }
        
        struct ViewModel {
        }
    }
    
    enum GetSocial {
        struct Request {
        }
        
        struct Response {
            var social: FileManagerResponse<Social>?
            var error: FileManagerError?
        }
        
        struct ViewModel {
        }
    }
    
}
