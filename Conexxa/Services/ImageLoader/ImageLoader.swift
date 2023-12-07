//
//  ImageLoader.swift
//  Conexxa
//
//  Created by Gabriel Castillo Serafim on 3/12/23.
//

import UIKit

@globalActor
actor GImageLoader {
    
    static var shared = GImageLoader()
    
    // MARK: Private
    
    private init() {}
    
    private var imageCache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 100
        cache.totalCostLimit = 1024 * 1024 * 100 // 100MB
        return cache
    }()
    
    private func addImageToCache(image: UIImage, url: String) {
        imageCache.setObject(image, forKey: url as NSString)
    }
    
    private func getImageFromCache(url: String) -> UIImage? {
        imageCache.object(forKey: url as NSString)
    }
    
    // MARK: Public
    
    func downloadImage(urlString: String) async throws -> UIImage {
        
        if let image = getImageFromCache(url: urlString) {
            return image
        }
        
        do {
            
            guard let url = URL(string: urlString) else { throw ImageLoaderError.badURL }
            
            try Task.checkCancellation()
            
            let (data, response) = try await URLSession.shared.data(from: url)
            
            if let httpResponse = response as? HTTPURLResponse,
               !(200..<300).contains(httpResponse.statusCode)
            {
                throw ImageLoaderError.failedWithStatusCode(statusCode: httpResponse.statusCode)
            }
            
            guard let image = UIImage(data: data) else { throw ImageLoaderError.couldNotGenerateImageFromData }
            
            addImageToCache(image: image, url: urlString)
            
            return image
            
        } catch {
            
            throw ImageLoaderError.unknown(description: error.localizedDescription)
        }
    }
    
}
