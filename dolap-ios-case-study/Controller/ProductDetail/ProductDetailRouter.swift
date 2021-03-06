//
//  ProductDetailRouter.swift
//  dolap-ios-case-study
//
//  Created by Emre Çelik on 5.11.2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

@objc protocol ProductDetailRoutingLogic {
}

protocol ProductDetailDataPassing {
    var dataStore: ProductDetailDataStore? { get }
}

class ProductDetailRouter: NSObject, ProductDetailRoutingLogic, ProductDetailDataPassing {
    weak var viewController: ProductDetailViewController?
    var dataStore: ProductDetailDataStore?
}
