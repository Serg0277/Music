//
//  ViewController.swift
//  myMusic
//
//  Created by  Сергей on 27.07.2022.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    public var currentUser: selectUser?
    public var songs = [Song]()

    let myTable : UITableView = {
        let table = UITableView()
        table.register(myTableViewCell.self,
                       forCellReuseIdentifier: myTableViewCell.identifier) // регистрация ячейки она у нас  отдельным файлом
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let currentUser = currentUser else {
            return
            
        }
        configureSoungs(value: currentUser)
        myTable.frame = view.bounds
        myTable.dataSource = self
        myTable.delegate = self
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.addSubview(myTable)
    }
    
    func  configureSoungs(value: selectUser) {
        Music.shared.configUserMusic(value: value) { [weak self] result in
            switch result {
            case .success(let playList):
                self?.songs = playList
            case .failure(let err):
                print("Ошибка загрузки плей листа \(err)")
            }
        }
    }
    
    //MARK: -  Настройка таблицы
    
    // количество строк
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    //содержание ячеки
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: myTableViewCell.identifier
                                                 , for: indexPath) as! myTableViewCell
        let song = songs[indexPath.row]
        cell.configure(with: song)
        //cell.accessoryType = .disclosureIndicator // вид курсора чтоли
        return cell
    }
    //выбор ячеки
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //представляем плеер
        let position = indexPath.row
        //song
       
        let vc = PlayerViewController()
        
        vc.songs = songs
        vc.position = position
        present(vc, animated: true)
    }
    // высота ячейки
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
}


