//
//  Music.swift
//  myMusic
//
//  Created by  Сергей on 12.05.2023.
//

import Foundation

enum selectUser {
    case Serg, Vika, Child, Sofi, All
}
class Music {
    
    public var songs:[Song] = []
    static let shared = Music()
    public func configUserMusic(value : selectUser, completion: @escaping ((Result<[Song], Error>) -> Void)){
        
        switch value {
        case .Serg:
            let playList = PlayListSerg.shared.configurePlayListForSerg()
            completion(.success(playList))
        case .Vika:
            let playList =  PlayListVika.shared.configurePlayListForVika()
            completion(.success(playList))
        case .Child:
            let playList =  PlayListChild.shared.configurePlayListForChild()
            completion(.success(playList))
        case .All:
            break
        case .Sofi:
            break
        }
    }
}



