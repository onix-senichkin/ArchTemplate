//
//  ImageCachingService.swift
//  ArchitectureTemplate
//
//  Created by Denis Senichkin on 15.06.2022.
//  Copyright © 2022 Denis Senichkin. All rights reserved.
//

import Foundation
import UIKit
import CryptoKit

private let kDaysToObsolete: Int = 14

protocol ImageCachingServiceType {
    func load(from imageURL: URL?, completion: ((UIImage?) -> Void)?)
    func cleanAllCache()
}

class ImageCachingService: ImageCachingServiceType {
    static let shared: ImageCachingServiceType = ImageCachingService()
    private var pathForFolder: String?
    
    init() {
        createPathForFolder()

        //debug only
        //cleanAllCache()
        cleanOldCache()
    }
    
    func load(from imageURL: URL?, completion: (SimpleClosure<UIImage?>)? = nil) {
        //print("ImageCachingService start url \(imageURL?.absoluteString ?? "")")
        guard let url = imageURL else {
            completion?(nil)
            return
        }

        //check for cache
        if let image = loadImageFromCache(url: url.absoluteString) {
            //print("ImageCachingService load form cache url \(imageURL?.absoluteString ?? "")")
            completion?(image)
            return
        }

        let request = URLRequest(url: url)
        DispatchQueue.global(qos: .userInitiated).async {
            let session = URLSession.shared.dataTask(with: request, completionHandler: { [weak self] data, response, _ in
                if let data = data, let response = response, ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300, let image = UIImage(data: data) {
                    //print("ImageCachingService \(Date()) load orig \(image.size), size \(data.count/1024)KB")
                    //resize image to device screen if needed
                    let screenWidth = UIScreen.main.bounds.width * UIScreen.main.scale
                    if image.size.width > screenWidth, let resized = image.resizedTo(width: screenWidth), let resizedData = resized.jpegData(compressionQuality: 1) { // resize image
                        self?.saveImageToCache(url: url.absoluteString, imageData: resizedData)
                        //print("ImageCachingService \(Date()) resize screenWidth \(screenWidth), orig \(image.size), size: \(data.count/1024)KB, resized \(resized.size), size: \(resizedData.count/1024)KB")
                        completion?(resized)
                    }
                    
                    self?.saveImageToCache(url: url.absoluteString, imageData: data)
                    completion?(image)
                } else {
                    completion?(nil)
                }
            })
            session.resume()
        }
    }
    
    private func saveImageToCache(url: String, imageData: Data) {
        guard let filePath = getPath(urlString: url) else { return }
        let filePathUrl = URL(fileURLWithPath: filePath)
        try? imageData.write(to: filePathUrl)
    }
    
    private func loadImageFromCache(url: String) -> UIImage? {
        guard let filePath = getPath(urlString: url) else { return nil }
        if checkFromImageFromCache(url: url) {
            //print("loadImageFromCache \(filePath)")
            if let image = UIImage(contentsOfFile: filePath) {
                self.updateFileModificationDate(path: filePath) // update file modification date on each read, to delete not used on startup
                return image
            }
        }
        return nil
    }
    
    private func checkFromImageFromCache(url: String) -> Bool {
        guard let filePath = getPath(urlString: url) else { return false }
        if FileManager.default.fileExists(atPath: filePath) {
            return true
        }
        return false
    }
}

// MARK: - Disk routine
extension ImageCachingService {
    
    func cleanAllCache() {
        guard let folder = pathForFolder else { return }
        let folderURL = URL(fileURLWithPath: folder)
        try? FileManager.default.removeItem(at: folderURL)
        
        createPathForFolder()
    }
    
    func cleanOldCache() {
        guard let folder = pathForFolder else { return }
        let folderURL = URL(fileURLWithPath: folder)
        
        let fileManager = FileManager.default
        guard let directoryContents = try? fileManager.contentsOfDirectory(at: folderURL, includingPropertiesForKeys: nil) else { return }
        for item in directoryContents {
            if item.pathExtension != "jpg" { continue }
            
            guard let fileAttr = try? fileManager.attributesOfItem(atPath: item.path), let modifTime = fileAttr[FileAttributeKey.modificationDate] as? Date else { continue }
            
            let dateComp = Calendar.current.dateComponents([.day], from: modifTime, to: Date())
            guard let differ = dateComp.day else { continue }
            if differ > kDaysToObsolete { // not opened for a time, remove it
                print("cleanOldCache delete \(item.lastPathComponent), modifTime \(modifTime)")
                try? fileManager.removeItem(atPath: item.path)
            }
        }
    }

    func updateFileModificationDate(path: String) {
        let fileManager = FileManager.default
        guard var fileAttr = try? fileManager.attributesOfItem(atPath: path) else { return }
        //print("updateFileModificationDate \(path), modifTime \(Date())")
        fileAttr[FileAttributeKey.modificationDate] = Date()
        try? fileManager.setAttributes(fileAttr, ofItemAtPath: path)
    }
    
    private func createPathForFolder() {
        guard let cacheDirPath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first else { return }
        let folderPath = cacheDirPath + "/ImageViewCache"
        
        if FileManager.default.fileExists(atPath: folderPath) == false {
            do {
                try FileManager.default.createDirectory(atPath: folderPath, withIntermediateDirectories: false, attributes: nil)
            } catch let error as NSError {
                debugPrint(error.localizedDescription)
            }
        }
        pathForFolder = folderPath
    }
    
    private func getPath(urlString: String) -> String? {
        // added url contain runtime query items, cache dont work
        guard let url = URL(string: urlString), let host = url.host else { return nil }
        guard let path = pathForFolder else { return nil }
        let file = (host + url.path).MD5()
        let fileUrl = path + "/" + file + ".jpg"
        return fileUrl
    }
}

extension UIImage {
    
    func resizedTo(width: CGFloat, isOpaque: Bool = true) -> UIImage? {
        if self.size.width < width {
            return self
        }
        
        let destinationSize = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        let format = imageRendererFormat
        format.opaque = isOpaque
        return UIGraphicsImageRenderer(size: destinationSize, format: format).image(actions: { _ in
            draw(in: CGRect(origin: .zero, size: destinationSize))
        })
    }
}

extension String {
    
    func MD5() -> String {
        let hash = Insecure.MD5.hash(data: self.data(using: .utf8) ?? Data())
        let md5Hex = hash.map { String(format: "%02x", $0) }.joined()
        return md5Hex
    }
}
