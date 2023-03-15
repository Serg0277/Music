//
//  myTableViewCell.swift
//  myMusic
//
//  Created by  Сергей on 28.07.2022.
//

import UIKit

class myTableViewCell: UITableViewCell {
    
    static let identifier = "cell" // статическое свойство чтобы потом мы могли зарегистрировать нашу ячейку
    
    // изображение
    private let userImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 35
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
                                     width: 70,
                                     height: 70)
        
        MusicLable.frame = CGRect(x: userImageView.right + 10,
                                  y: 10,
                                  width: contentView.width - 20 - userImageView.width,
                                  height: (contentView.height - 20)/4)
        
        artistNameLable.frame = CGRect(x: userImageView.right + 10,
                                       y: MusicLable.bottom + 5,
                                       width: contentView.width - 20 - userImageView.width,
                                       height: (contentView.height - 20)/2)
    }
    /// Modell
    public func configure(with model: Song){
        self.userImageView.image = UIImage(named: model.imageName)
        self.MusicLable.text = model.name
        self.artistNameLable.text = model.artistName
    }
}
