//
//  ViewController.swift
//  myMusic
//
//  Created by  Сергей on 27.07.2022.
// экран для выбора треков

import UIKit
import AVFoundation

class ListMusicViewController: UIViewController{
    
    private var songs : [SongUrl] = []
    private var musicUrl : [URL] = []
    private var position = 0
    
    private let myTable : UITableView = {
        let table = UITableView()
        table.register(myTableViewCell.self,
                       forCellReuseIdentifier: myTableViewCell.identifier) // регистрация ячейки она у нас  отдельным файлом
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTable.frame = view.bounds
        myTable.dataSource = self
        myTable.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.addSubview(myTable)
        configMusicContent()
    }
    
    //отвечает за загрузку контента и его проверку и сортировку и тд
    private func configMusicContent(){
        musicUrl.removeAll()
        //получаем ссылку на наше хранилище это нужно елать так статичный адрес не использовать!
        guard  let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return
        }
        do {
            //получаем все что хранится по адресу все файлы
            let contentUrl = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)//пропуская скрытые
            //это тема! фильтруем адреса по префиксу
            musicUrl  = contentUrl.filter { url in
                let pathExtension = url.pathExtension
                return ["mp3"].contains(pathExtension)
            }
            commonMetadata()
        }catch{
            print(error.localizedDescription)
        }
    }
    //получение метаданных из массива песен
    private func commonMetadata(){
        songs.removeAll()
        for url in musicUrl {
            let asset = AVURLAsset(url: url)
            let commonMetaDataArray = asset.metadata
            guard var content : SongUrl = returnArraySong(contentMeta: commonMetaDataArray) else {return}
            content.trackName = url
            songs.append(content)
            DispatchQueue.main.async {
                self.myTable.reloadData()
            }
            
        }
    }
    //получение мета данных конкретного файла и разбор его на запчасти
    private func returnArraySong(contentMeta: [AVMetadataItem]) -> SongUrl?{
        var dataTrack = SongUrl()
        for dataTreck in contentMeta {
            guard let key = dataTreck.commonKey, let value = dataTreck.value?.description else{
                continue
            }
            switch key {
            case .commonKeyTitle :
                dataTrack.name = value
            case .commonKeyAlbumName:
                dataTrack.albumName = value
            case .commonKeyArtist:
                dataTrack.artistName = value
            case .commonKeyArtwork:
                dataTrack.imageData =  dataTreck.value as? Data
            default:
                continue
            }
        }
        return dataTrack
    }
}
//MARK: -  Настройка таблицы
extension ListMusicViewController:  UITableViewDelegate, UITableViewDataSource {
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
        //cell.accessoryType = .disclosureIndicator // вид курсора
        return cell
    }
    
    //выбор ячеки
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //представляем плеер
        let position = indexPath.row
        //song
        let vc = PlayMusicViewController()
        vc.songs = songs
        vc.position = position
        present(vc, animated: true)
    }
    
    // высота ячейки
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}


