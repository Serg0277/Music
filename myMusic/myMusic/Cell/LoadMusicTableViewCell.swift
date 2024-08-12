//
//  ManagerTableViewCell.swift
//  myMusic
//
//  Created by  Сергей on 11.05.2024.
// так не называть больше какой конроллер ?

import UIKit

class ManagerTableViewCell: UITableViewCell {
    
    static let identifier = "ManagerTableViewCell"
    
    private let gifView : GifkaView = {
        let gif = GifkaView()
        gif.isHidden = true
        return gif
    }()
    
    
    private let userImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 30
        imageView.clipsToBounds = true
        return imageView
    }()
    
    //название песни
    private let musicNameLable : UILabel = {
        let lable = UILabel()
        lable.font = .systemFont(ofSize: 20, weight: .semibold)
        return lable
    }()
    
    //исполнитель или группа
    private let artistNameLable: UILabel = {
        let lable = UILabel()
        lable.font = .systemFont(ofSize: 14, weight: .ultraLight)
        lable.numberOfLines = 0
        return lable
    }()
    
    private let albumNameLable: UILabel = {
        let lable = UILabel()
        lable.font = .systemFont(ofSize: 14, weight: .ultraLight)
        lable.numberOfLines = 0
        return lable
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //     isUserInteractionEnabled = true
        //     isUserInteractionEnabled = true
        //    let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapSetGifka))
        //количество касаний и количество нажатий
        //    gesture.numberOfTapsRequired = 1
        //   gesture.numberOfTouchesRequired = 1
        //    contentView.addGestureRecognizer(gesture)
        
        contentView.addSubview(userImageView)
        contentView.addSubview(musicNameLable)
        contentView.addSubview(albumNameLable)
        contentView.addSubview(artistNameLable)
        contentView.addSubview(gifView)
        
        
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        userImageView.frame = CGRect(x: 10,
                                     y: 10,
                                     width: 60,
                                     height: 60)
        gifView.frame = CGRect(x: 10,
                               y: 10,
                               width: 60,
                               height: 60)
        
        musicNameLable.frame = CGRect(x: userImageView.right + 15,
                                      y: 5,
                                      width: contentView.width - 20 - userImageView.width,
                                      height: 20)
        
        artistNameLable.frame = CGRect(x: userImageView.right + 15,
                                       y: musicNameLable.bottom + 5,
                                       width: contentView.width - 20 - userImageView.width,
                                       height: 20)
        albumNameLable.frame = CGRect(x: userImageView.right + 15,
                                      y: artistNameLable.bottom + 5,
                                      width: contentView.width - 20 - userImageView.width,
                                      height: 20)
    }
    
    public func stopGif(){
     gifView.configureView(statusGif: false)
     gifView.isHidden = true
        
    }
    
    public func playgif(){
     gifView.configureView(statusGif: true)
     gifView.isHidden = false
    }
    /// Modell
    ///
    ///
    public func configure(with model: SongUrl){
        
        DispatchQueue.main.async {[weak self] in
            if let dataImage = model.imageData {
                self?.userImageView.image = UIImage(data: dataImage)
            }else{
                self?.userImageView.image = UIImage(systemName: "music.note.list")
            }
        }
        musicNameLable.text = model.name
        artistNameLable.text = model.artistName
        albumNameLable.text = model.albumName
    }
    
    override func prepareForReuse() {
        userImageView.image  = nil
    }
}
