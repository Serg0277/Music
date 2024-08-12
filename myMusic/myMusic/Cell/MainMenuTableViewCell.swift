//
//  myTableViewCell.swift
//  myMusic
//
//  Created by  Сергей on 28.07.2022.
// так не называть больше какой конроллер ?

import UIKit

class myTableViewCell: UITableViewCell {
    
    static let identifier = "cell" // статическое свойство чтобы потом мы могли зарегистрировать нашу ячейку
  
    // изображение
    private let userImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: "music.note.list")
        imageView.layer.cornerRadius = 30
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    //название песни
    private let MusicLable : UILabel = {
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
    
   override func awakeFromNib() {
    super.awakeFromNib()
        
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(userImageView)
        contentView.addSubview(MusicLable)
        contentView.addSubview(artistNameLable)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    // вторая функция переопределения вложенных представлений макета то же жз что значит))
    override func layoutSubviews() {
        super.layoutSubviews()
        userImageView.frame = CGRect(x: 10,
                                     y: 10,
                                     width: 60,
                                     height: 60)
        
        MusicLable.frame = CGRect(x: userImageView.right + 15,
                                  y: 10,
                                  width: contentView.width - 20 - userImageView.width,
                                  height: (contentView.height - 20)/2)
        
        artistNameLable.frame = CGRect(x: userImageView.right + 15,
                                       y: MusicLable.bottom + 10,
                                       width: contentView.width - 20 - userImageView.width,
                                       height: (contentView.height - 20)/2)
    }
    /// Modell
    public func configure(with model: SongUrl){
    
        DispatchQueue.main.async {
         if  let dataImage = model.imageData {
                self.userImageView.image = UIImage(data: dataImage)
         }else{
             self.userImageView.image = UIImage(systemName: "music.note.list")
         }
        }
        self.MusicLable.text = model.name
        self.artistNameLable.text = model.artistName
    }
    
    override func prepareForReuse() {
        userImageView.image  = nil
    }
}
