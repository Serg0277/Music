//
//  SettingFileManager.swift
//  myMusic
//
//  Created by  Сергей on 23.07.2024.
// менеджер работы с файлами


import Foundation

class SetupFileManager{
    
   static let shared = SetupFileManager()
    // это адрес по дефолту нашего приложения
    private let playListDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
   
    public func addSongPlayList(_ palyList:[PlayListModel], playListName: String){
        let nameFile = playListName
        //создаем путь к файлу
        let playListPatch = playListDirectory.appendingPathComponent(nameFile)
      //форматируем в JSON
        do {
            let data = try JSONEncoder().encode(palyList)
            try data.write(to: playListPatch)
            print("Плейлист \(nameFile) успешно сохранен")
        }catch{
            print("Ошибка записи плейлиста \(nameFile)")
        }
    }
    
    public func updateSongPlayList(_ palyList:[PlayListModel], playListName: String){
        let nameFile = playListName
        //создаем путь к файлу
        let playListPatch = playListDirectory.appendingPathComponent(nameFile)
      //форматируем в JSON
        do {
            let data = try JSONEncoder().encode(palyList)
            try data.write(to: playListPatch)
            print("Плейлист  \(playListName) успешно обновлен")
        }catch{
            print("Ошибка записи плейлиста \(nameFile)")
        }
       
    }
    
    public func loadPlayList(playListName: String, completion: (Result<[PlayListModel], Error>) -> Void){
        let nameFile = playListName
        //создаем путь к файлу
        let playListPatch = playListDirectory.appendingPathComponent(nameFile)
        do {
            let data = try Data(contentsOf: playListPatch)
            let items = try  JSONDecoder().decode([PlayListModel].self, from: data)
            completion(.success(items))
        }catch{
            
            completion(.failure(error))
        }
    }
    
    //загрузка все имеющихся плейлистов
    
    public func loadAllPlayList(completion: (Result<[URL], Error>) -> Void){
       
        do {
            //получаем все что хранится по адресу все файлы
            let allFiles = try FileManager.default.contentsOfDirectory(at: playListDirectory, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)//пропуская скрытые
            //это тема! фильтруем адреса по префиксу
            let namePlayList: [URL]  = allFiles.filter { url in
                let pathExtension = url.pathExtension
                return ["json"].contains(pathExtension)
            }
            completion(.success(namePlayList))
        }catch{
            completion(.failure(error))
        }
    }
                
    

    
    
    
    //
    public func deletSongFromPlayList(playListName: String, song: PlayListModel){
       print("Плейлист \(playListName) успешно удален")
    }
}
