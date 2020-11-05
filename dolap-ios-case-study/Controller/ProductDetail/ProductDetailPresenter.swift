//
//  ProductDetailPresenter.swift
//  dolap-ios-case-study
//
//  Created by Emre Çelik on 5.11.2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol ProductDetailPresentationLogic {
    func presentProduct(response: ProductDetail.GetProduct.Response)
    func presentSocial(response: ProductDetail.GetSocial.Response)
    func presentLoading()
    func hideLoading()
}

class ProductDetailPresenter: ProductDetailPresentationLogic {
    weak var viewController: ProductDetailDisplayLogic?
    
    func presentProduct(response: ProductDetail.GetProduct.Response) {
        if let error = response.error {
            viewController?.displayError(error: error); return
        }
        guard let product = response.product?.model else {
            viewController?.displayEmpty(); return
        }
        viewController?.displayProduct(product: product)
    }
    
    func presentSocial(response: ProductDetail.GetSocial.Response) {
        if let error = response.error {
            viewController?.displayError(error: error); return
        }
        guard let social = response.social?.model else {
            viewController?.displayEmpty(); return
        }
        viewController?.displaySocial(social: social)
    }
    
    func presentLoading() {
        viewController?.displayLoading()
    }
    
    func hideLoading() {
        viewController?.hideLoading()
    }
    
}
