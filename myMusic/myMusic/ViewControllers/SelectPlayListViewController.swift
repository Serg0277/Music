//
//  selectPlayListViewConrtroller.swift
//  myMusic
//
//  Created by  Сергей on 02.08.2024.
//выбор или зоднание названия плейлиста

import UIKit

class SelectPlayListViewConrtroller: UIViewController {

    private var playListName : String?
    
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        super.viewDidLoad()
       
        setupView()
    }
    
    private func setupView(){
        
    }
    
    private func loadAllPlayList(){
        SetupFileManager.shared.loadAllPlayList { result in
            switch result {
                
            case .success(_):
                <#code#>
            case .failure(_):
                <#code#>
            }
        }
        
    }
}
