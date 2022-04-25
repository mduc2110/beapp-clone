//
//  Extensions.swift
//  beclone
//
//  Created by duc.vu1 on 04/04/2022.
//

import Foundation


import UIKit

extension UIImageView {

    func load(urlString : String)  {
        guard let url = URL(string : urlString) else {
            return
        }
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url),
               let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
        }
    }
}
