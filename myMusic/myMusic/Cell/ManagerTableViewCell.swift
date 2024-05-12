//
//  ManagerTableViewCell.swift
//  myMusic
//
//  Created by  Сергей on 11.05.2024.
//

import UIKit

class ManagerTableViewCell: UITableViewCell {

    static let identifier = "ManagerTableViewCell"
  
    private let userImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 30
        imageView.layer.masksToBounds = true
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
        contentView.addSubview(userImageView)
        contentView.addSubview(musicNameLable)
        contentView.addSubview(albumNameLable)
        contentView.addSubview(artistNameLable)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
   
    override func layoutSubviews() {
        super.layoutSubviews()
        userImageView.frame = CGRect(x: 10,
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
    /// Modell
    public func configure(with model: SongUrl){
        
        DispatchQueue.main.async {
            if let dataImage = model.imageData {
                self.userImageView.image = UIImage(data: dataImage)
            }
        }
        self.musicNameLable.text = model.name
        self.artistNameLable.text = model.artistName
        self.albumNameLable.text = model.albumName
    }
}
