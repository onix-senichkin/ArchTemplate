//
//  UIImageView.swift
//  ArchitectureTemplate
//
//  Created by Denis Senichkin on 15.06.2022.
//  Copyright © 2022 Denis Senichkin. All rights reserved.
//

import UIKit

extension UIButton {
    
    func load(from imageURL: URL, defaultImage: UIImage? = nil, completion: (() -> Void)? = nil) {
        load(from: imageURL.absoluteString, defaultImage: defaultImage, completion: completion)
    }
    
    func load(from imageURL: String, defaultImage: UIImage? = nil, completion: (() -> Void)? = nil) {
        self.setImage(defaultImage, for: .normal)
        guard let url = URL(string: imageURL) else { return }
        
        self.restorationIdentifier = url.absoluteString // save url and recheck it on complete to prevent flickering on multitple concurrent requests

        ImageCachingService.shared.load(from: url) { [weak self] image in
            DispatchQueue.main.async { [weak self] in
                if let restorationIdentifier = self?.restorationIdentifier, restorationIdentifier != url.absoluteString { // other request started, ignore this image
                    //print("UIButton load restorationIdentifier != url.absoluteString, restorationIdentifier \(restorationIdentifier), url \(url.absoluteString)")
                    completion?()
                    return
                }
                self?.setImage(image ?? defaultImage, for: .normal)
                completion?()
            }
        }
    }
}

extension UIImageView {
    
    func load(from imageURL: String, defaultImage: UIImage? = nil, completion: (() -> Void)? = nil) {
        guard let url = URL(string: imageURL) else { return }
        load(from: url, defaultImage: defaultImage, completion: completion)
    }
    
    func load(from imageURL: URL?, defaultImage: UIImage? = nil, completion: (() -> Void)? = nil) {
        self.image = defaultImage
        guard let url = imageURL else { return }
        
        self.restorationIdentifier = url.absoluteString // save url and recheck it on complete to prevent flickering on multitple concurrent requests
        //print("UIImageView start restorationIdentifier \(url.absoluteString)")

        ImageCachingService.shared.load(from: url) { [weak self] image in
            DispatchQueue.main.async { [weak self] in
                if let restorationIdentifier = self?.restorationIdentifier, restorationIdentifier != url.absoluteString { // other request started, ignore this image
                    //print("UIImageView error restorationIdentifier \(restorationIdentifier), url \(url.absoluteString)")
                    completion?()
                    return
                }
                //print("UIImageView done restorationIdentifier \(self?.restorationIdentifier ?? ""), url \(url.absoluteString)")
                self?.image = image ?? defaultImage
                completion?()
            }
        }
    }
}
