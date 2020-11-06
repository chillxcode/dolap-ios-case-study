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
            switch error {
            case .notFound:
                viewController?.displayError(message: "File not found")
                break
            case .fileNotReadable:
                viewController?.displayError(message: "File not readable")
                break
            case .fileDecode:
                viewController?.displayError(message: "File decode error")
                break
            }
            return
        }
        guard let product = response.product?.model else {
            viewController?.displayEmpty(); return
        }
        viewController?.displayProduct(product: product)
    }
    
    func presentSocial(response: ProductDetail.GetSocial.Response) {
        if let error = response.error {
            switch error {
            case .notFound:
                viewController?.displayError(message: "File not found")
                break
            case .fileNotReadable:
                viewController?.displayError(message: "File not readable")
                break
            case .fileDecode:
                viewController?.displayError(message: "File decode error")
                break
            }
            return
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
