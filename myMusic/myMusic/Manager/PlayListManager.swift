//
//  PlayListManager.swift
//  myMusic
//
//  Created by  Сергей on 23.07.2024.
// менеджер работы с PlayList

import Foundation

struct PlayListModel: Codable {
    var name : String?
    // var albumName : String?
    //var artistName : String?
    var imageData : Data?
    var trackName : URL?
    init(model: SongUrl){
        self.name = model.name
        self.imageData = model.imageData
        self.trackName = model.trackName
    }
}

final class PlayListManager{
    
    static let shared = PlayListManager()
    
    private var countPress = 0
    
    private var playListModel : [PlayListModel] = []
    
    
    
    //добавляем композицию в плейлист
    public func addPlayList(selectPlayListString: String?, song: PlayListModel){
        //проверяем новый это плейл лист?
        if let selectPlayListString = selectPlayListString{
            //функция загрузки плейлиста из файла
            SetupFileManager.shared.loadPlayList(playListName: selectPlayListString) { result in
                switch result {
                case .success(let value):
                    playListModel = value
                    //проверяем есть ли такая композиция в плейлисте
                    playListModel.forEach { value in
                        if  value.trackName == song.trackName {
                            print("Такая композиция уже имеется в плай листе!")
                        }else{
                            //добавляем в массив песен
                            playListModel.append(song)
                            //обнавляем файл
                            SetupFileManager.shared.updateSongPlayList(playListModel, playListName: selectPlayListString)
                        }
                    }
                    //елм по каким либо пречинам загрузить указанный файл не удалось
                case .failure(let erro):
                    print("не удалось загрузить данные из плейлиста \(selectPlayListString) ошибка \(erro)")
                }
            }
        }else{
            //если это новый плелист то создаем ему название(надо придумать как) и далее...
            let newPlayListNameString = "PlayList1.json"
            //добавляем в массив песен , не проверяем так как там нет еще ничего
            playListModel.append(song)
            //обнавляем файл
            SetupFileManager.shared.updateSongPlayList(playListModel, playListName: newPlayListNameString)
        }
    }
    
    //функция удаляет композицию из массива
    public func deletePlayList(selectPlayListString: String, song: PlayListModel){
        //функция загрузки плейлиста из файла
        SetupFileManager.shared.loadPlayList(playListName: selectPlayListString) { result in
            switch result {
            case .success(let songArray):
                playListModel = songArray
                //удаляем из массива
                var songPosition = 0
                playListModel.forEach { value in
                    if value.trackName == song.trackName {
                        playListModel.remove(at: songPosition)
                        //обнавляем файл
                        let playListNameString = "PlayList1.json" //это потом поменять на реальное имя
                        SetupFileManager.shared.updateSongPlayList(playListModel, playListName: playListNameString)
                    }
                    songPosition += 1
                }
                
            case .failure(let error):
                print("Загрузка плейлиста из функции удления не удалась - \(error)")
            }
        }
    }
    
}
