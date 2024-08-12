//
//  GifImage.swift
//  myMusic
//
//  Created by  Сергей on 27.06.2024.
//

import Foundation
import UIKit

extension UIImage {
    
    class func gifImageWithData(_ data: Data) -> UIImage? {
            guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
                return nil
            }
            
            let frameCount = CGImageSourceGetCount(source)
            var images: [UIImage] = []
            
            for i in 0..<frameCount {
                if let cgImage = CGImageSourceCreateImageAtIndex(source, i, nil) {
                    let image = UIImage(cgImage: cgImage)
                    images.append(image)
                }
            }
            
            return UIImage.animatedImage(with: images, duration: 0.0)
        }
    }
