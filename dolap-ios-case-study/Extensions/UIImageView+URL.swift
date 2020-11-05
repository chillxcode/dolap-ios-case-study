//
//  UIImageView+imageFromURL.swift
//  dolap-ios-case-study
//
//  Created by Emre Çelik on 5.11.2020.
//

import Foundation
import UIKit

extension UIImageView {
    
    public func imageFromUrl(urlString: String) {
        guard let url = NSURL(string: urlString),
              let data = NSData(contentsOf: url as URL),
              let image = UIImage(data: data as Data)
        else {
            self.image = UIImage(named: "image-not-found"); return
        }
        self.image = image
    }
    
}
