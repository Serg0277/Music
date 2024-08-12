
//  SelectPlayListViewController.swift
//  myMusic
//  Created by  Сергей on 12.05.2023.
//  самый первый Экран просто выбираем куда дальше

import UIKit

class HomeViewController: UIViewController {
    
    private let imageView : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "kasseta")
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private let allMusicLabel: UILabel = {
        let label = UILabel()
        label.text = "All music"
        label.textColor = .yellow
        label.font = .systemFont(ofSize: 21, weight: .heavy)
        return label
    }()
    
    private let loadMusicLabel: UILabel = {
        let label = UILabel()
        label.text = "Load music"
        label.textColor = .yellow
        label.font = .systemFont(ofSize: 21, weight: .heavy)
        return label
    }()
    
    private let playListLabel: UILabel = {
        let label = UILabel()
        label.text = "Play list"
        label.textColor = .yellow
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 21, weight: .heavy)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
        title = "Buben MP3"

        imageView.addSubview(allMusicLabel)
        imageView.addSubview(loadMusicLabel)
        imageView.addSubview(playListLabel)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "settings.png"),
                                                                    style: .done,
                                                                    target: self,
                                                                    action: #selector(didTapSettings))
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
       
        allMusicLabel.frame = CGRect(x: view.left + 30,
                                     y: view.height / 3,
                                width: view.width - 60,
                                    height: 52)
        
        playListLabel.frame = CGRect(x: view.left + 30,
                                y: allMusicLabel.bottom + 40,
                                width: view.width - 60,
                                height: 52)
        
        loadMusicLabel.frame = CGRect(x: view.left + 30,
                                      y: playListLabel.bottom + 40,
                                      width: view.width - 60,
                                      height: 52)
    }
    
    @objc private func  didTapSettings(){
        print("Настройки")
    }
    //нажатие на экран
    @objc private func didTapScreen(_ sender: UIGestureRecognizer){
        let locationItem = sender.location(in: nil)
        let vc = MainMenuViewController()
        //contains - содержит
        if allMusicLabel.frame.contains(locationItem) {
            navigationController?.pushViewController(vc, animated: true)
        }else if loadMusicLabel.frame.contains(locationItem){
            let vc = LoadMusicViewController()
            navigationController?.pushViewController(vc, animated: true)
        }else if playListLabel.frame.contains(locationItem){
            let vc = ListMusicViewController()
            navigationController?.pushViewController(vc, animated: true)
        }else{
            return
        }
    }
}

