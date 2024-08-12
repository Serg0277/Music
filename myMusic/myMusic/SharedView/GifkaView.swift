//
//  ViewGifka.swift
//  myMusic
//
//  Created by  Сергей on 02.07.2024.
// сделано через отдельную вьюи нспользуется на главном экране задача показать гиф при нажатии на ячеку

import UIKit

final class GifkaView : UIView {
    //сделал отдельно так как тупит при скролле
    private var gifImage: UIImage?
    
    private let gifImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 30
        imageView.clipsToBounds = true
        return imageView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        gifImage = createGifComponent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .systemBackground
        addSubview(gifImageView)
    }
    
    private func createGifComponent() -> UIImage?{
        guard let gifPath = Bundle.main.path(forResource: "gifka5", ofType: "gif") else {
            print("Failed to find the GIF image.")
            return nil
        }
        guard let gifData = try? Data(contentsOf: URL(fileURLWithPath: gifPath)) else {
            print("Failed to load the GIF image data.")
            return nil
        }
        if let gifImage = UIImage.gifImageWithData(gifData) {
            return gifImage
        }else{
            print("Failed to create the GIF image.")
            return nil
        }
    }
    
    func configureView(statusGif: Bool){
        if statusGif{
            gifImageView.image = gifImage
        }else{
            gifImageView.image = nil
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gifImageView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
    }
}
