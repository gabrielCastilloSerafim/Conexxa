//
//  ImageLoaderUIImageExtension.swift
//  Conexxa
//
//  Created by Gabriel Castillo Serafim on 3/12/23.
//

import UIKit

extension UIImageView {
    
    // MARK: Private
    
    private static var _activeDataTasks = [String: Task<(), Never>]()
    
    private var activeDataTask: Task<(), Never>? {
        
        get {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            return UIImageView._activeDataTasks[tmpAddress]
        }
        
        set(newValue) {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            UIImageView._activeDataTasks[tmpAddress] = newValue
        }
    }
    
    private func removeCompletedDataTask() {
        
        let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
        UIImageView._activeDataTasks.removeValue(forKey: tmpAddress)
    }
    
    // MARK: Public
    
    func downloadImage(urlString: String, placeHolder: UIImage? = nil) {
        
        var myTaks: Task<(), Never>
        
        myTaks = Task {
            
            do {
                
                let downloadedImage = try await GImageLoader.shared.downloadImage(urlString: urlString)
                
                await MainActor.run {
                    self.image = downloadedImage
                }
                
                removeCompletedDataTask()
                
            } catch {
                
                removeCompletedDataTask()
                
                debugPrint(error)
                
                guard !(error is CancellationError),
                      let placeHolder else { return }
                
                await MainActor.run {
                    self.image = placeHolder
                }
            }
        }
        
        activeDataTask = myTaks
    }
    
    func cancelTask() {
        activeDataTask?.cancel()
    }
}
