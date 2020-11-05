//
//  ProductDetailInteractor.swift
//  dolap-ios-case-study
//
//  Created by Emre Çelik on 5.11.2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol ProductDetailBusinessLogic {
    func fetchProduct(request: ProductDetail.GetProduct.Request)
    func fetchSocial(request: ProductDetail.GetSocial.Request)
}

protocol ProductDetailDataStore {
    //var name: String { get set }
}

class ProductDetailInteractor: ProductDetailBusinessLogic, ProductDetailDataStore {
    var presenter: ProductDetailPresentationLogic?
    var worker: ProductDetailWorker?
    private var isLoading: Bool = false
    
    func fetchProduct(request: ProductDetail.GetProduct.Request) {
        if !isLoading {
            presenter?.presentLoading(); isLoading = true
        }
        worker = ProductDetailWorker()
        worker?.getProduct(onSuccess: { (productResponse) in
            self.presenter?.hideLoading()
            self.isLoading = true
            let response = ProductDetail.GetProduct.Response(product: productResponse, error: nil)
            self.presenter?.presentProduct(response: response)
        }, onError: { (fileManagerError) in
            self.presenter?.hideLoading()
            let response = ProductDetail.GetProduct.Response(product: nil, error: fileManagerError)
            self.presenter?.presentProduct(response: response)
        })
    }
    
    func fetchSocial(request: ProductDetail.GetSocial.Request) {
        if !isLoading {
            presenter?.presentLoading(); isLoading = true
        }
        worker = ProductDetailWorker()
        worker?.getSocial(onSuccess: { (socialResponse) in
            self.presenter?.hideLoading()
            self.isLoading = true
            let response = ProductDetail.GetSocial.Response(social: socialResponse, error: nil)
            self.presenter?.presentSocial(response: response)
        }, onError: { (fileManagerError) in
            self.presenter?.hideLoading()
            let response = ProductDetail.GetSocial.Response(social: nil, error: fileManagerError)
            self.presenter?.presentSocial(response: response)
        })
    }

}
