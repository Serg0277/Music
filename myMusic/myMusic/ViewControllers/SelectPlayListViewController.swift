
//  SelectPlayListViewController.swift
//  myMusic
//  Created by  Сергей on 12.05.2023.

import UIKit

class SelectPlayListViewController: UIViewController {
    
    private let imageView : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "avatar")
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private let selectPlayListLabel: UILabel = {
        let label = UILabel()
        label.text = "Выберите свой плейлист"
        label.textColor = .yellow
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 24, weight: .heavy)
        return label
    }()
    
    private let sergMusicLabel: UILabel = {
        let label = UILabel()
        label.text = "Сергей"
        label.textColor = .yellow
        label.font = .systemFont(ofSize: 21, weight: .heavy)
        return label
    }()
    
    private let vikaMusicLabel: UILabel = {
        let label = UILabel()
        label.text = "Вика"
        label.textColor = .yellow
        label.font = .systemFont(ofSize: 21, weight: .heavy)
        return label
    }()
    
    private let sofiMusicLabel: UILabel = {
        let label = UILabel()
        label.text = "София"
        label.textColor = .yellow
        label.font = .systemFont(ofSize: 21, weight: .heavy)
        return label
    }()
    
    private let childMusicLabel: UILabel = {
        let label = UILabel()
        label.text = "Музыка Саши и Никиты"
        label.textColor = .yellow
        label.font = .systemFont(ofSize: 21, weight: .heavy)
        return label
    }()
    
    private let loadMusicLabel: UILabel = {
        let label = UILabel()
        label.text = "Загрузить музыку"
        label.textColor = .yellow
        label.font = .systemFont(ofSize: 21, weight: .heavy)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
        imageView.addSubview(selectPlayListLabel)
        imageView.addSubview(sergMusicLabel)
        imageView.addSubview(vikaMusicLabel)
        imageView.addSubview(sofiMusicLabel)
        imageView.addSubview(childMusicLabel)
        imageView.addSubview(loadMusicLabel)
        //это обязательно иначе не работает
        view.isUserInteractionEnabled = true
        //sergMusicLabel.isUserInteractionEnabled = true
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapScreen))
        //количество касаний и количество нажатий
        tapRecognizer.numberOfTapsRequired = 1
        tapRecognizer.numberOfTouchesRequired = 1
        view.addGestureRecognizer(tapRecognizer)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.frame = view.bounds
        selectPlayListLabel.frame = CGRect(x: view.left + 30,
                                      y:  view.height/3,
                                      width: view.width - 60,
                                      height: 52)
        sergMusicLabel.frame = CGRect(x: view.left + 30,
                                      y: selectPlayListLabel.bottom + 20,
                                      width: view.width - 60,
                                      height: 52)
        vikaMusicLabel.frame = CGRect(x: view.left + 30,
                                      y: sergMusicLabel.bottom + 20,
                                      width: view.width - 60,
                                      height: 52)
        sofiMusicLabel.frame = CGRect(x: view.left + 30,
                                      y: vikaMusicLabel.bottom + 40,
                                      width: view.width - 60,
                                      height: 52)
        childMusicLabel.frame = CGRect(x: view.left + 30,
                                       y: sofiMusicLabel.bottom + 40,
                                       width: view.width - 60,
                                       height: 52)
        loadMusicLabel.frame = CGRect(x: view.left + 30,
                                       y: childMusicLabel.bottom + 40,
                                       width: view.width - 60,
                                       height: 52)
    }
    
    @objc private func didTapScreen(_ sender: UIGestureRecognizer){
        let locationItem = sender.location(in: nil)
        let target = sergMusicLabel.frame.contains(locationItem)
        let vc = MainViewController()
        //contains - содержит
        if sergMusicLabel.frame.contains(locationItem) {
            vc.currentUser = .Serg
        }else if vikaMusicLabel.frame.contains(locationItem){
            vc.currentUser = .Vika
        }else if childMusicLabel.frame.contains(locationItem){
            vc.currentUser = .Child
        }else if loadMusicLabel.frame.contains(locationItem){
            let vc = ManagerLoaderViewController()
            navigationController?.pushViewController(vc, animated: true)
            return
        }else{
            return
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}
