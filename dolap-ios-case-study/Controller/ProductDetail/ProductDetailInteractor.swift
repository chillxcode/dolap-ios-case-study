//
//  ProductDetailInteractor.swift
//  dolap-ios-case-study
//
//  Created by Emre Çelik on 5.11.2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol ProductDetailBusinessLogic {
    func doSomething(request: ProductDetail.Something.Request)
}

protocol ProductDetailDataStore {
    //var name: String { get set }
}

class ProductDetailInteractor: ProductDetailBusinessLogic, ProductDetailDataStore {
    var presenter: ProductDetailPresentationLogic?
    var worker: ProductDetailWorker?
    //var name: String = ""
    
    // MARK: Do something
    
    func doSomething(request: ProductDetail.Something.Request) {
        worker = ProductDetailWorker()
        worker?.doSomeWork()
        
        let response = ProductDetail.Something.Response()
        presenter?.presentSomething(response: response)
    }
}
