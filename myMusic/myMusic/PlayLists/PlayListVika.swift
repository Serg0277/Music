//
//  Vika.swift
//  myMusic
//
//  Created by  Сергей on 12.05.2023.
//

import Foundation

class PlayListVika {
    
    private var songs : [Song] = []
    static let shared = PlayListVika()
    public func configurePlayListForVika()  -> [Song] {

        songs.append(Song(name: "Я Ты и море",
                          albumName: "",
                          artistName: "Братья Гаязовы",
                          imageName: "7",
                          trackName: "7"))
        songs.append(Song(name: "Малиновая лада",
                          albumName: "",
                          artistName: "Братья Гаязовы",
                          imageName: "8",
                          trackName: "8"))
        
        songs.append(Song(name: "Хулиган",
                          albumName: "",
                          artistName: "Султан Лугачев, Ислам Итляшов",
                          imageName: "9",
                          trackName: "9"))
        songs.append(Song(name: "Я с ней живу я с ней кайфую",
                          albumName: "",
                          artistName: "Мурат Тхагалегов",
                          imageName: "10",
                          trackName: "10"))
        songs.append(Song(name: "Между нами война",
                          albumName: "",
                          artistName: "Султан Лугачев",
                          imageName: "11",
                          trackName: "11"))
        songs.append(Song(name: "Вкус твоей любви",
                          albumName: "",
                          artistName: "Султан Лугачев",
                          imageName: "12",
                          trackName: "12"))
        songs.append(Song(name: "Девочка, танцуй",
                          albumName: "ARTIK pres.ASTI",
                          artistName: "ARTIK pres.ASTI ",
                          imageName: "17",
                          trackName: "17"))
        songs.append(Song(name: "СОЛНЦЕ МОНАКО",
                          albumName: "",
                          artistName: "Люся Чеботина",
                          imageName: "18",
                          trackName: "18"))
        songs.append(Song(name: "По барам",
                          albumName: "ANNA ASTI",
                          artistName: "ANNA ASTI",
                          imageName: "19",
                          trackName: "19"))
        
           // Зиверт
        songs.append(Song(name: "Лайф",
                          albumName: "Зиверт",
                          artistName: "",
                          imageName: "30",
                          trackName: "30"))
        songs.append(Song(name: "поп-ремикс DJ Башир",
                          albumName: "DJ Башир Зиверт - Кредо",
                          artistName: "",
                          imageName: "31",
                          trackName: "31"))
        songs.append(Song(name: "Зеленые волны",
                          albumName: "ZIVERT ЮЛИЯ ЗИВЕРТ",
                          artistName: "",
                          imageName: "30",
                          trackName: "32"))
        //король и шут
       songs.append(Song(name: "Истеричка",
                          albumName: "Artik & Asti",
                          artistName: "",
                          imageName: "19",
                          trackName: "50"))
        songs.append(Song(name: "Что мы наделали",
                          albumName: "Elena_Vaenga",
                          artistName: "",
                          imageName: "60",
                          trackName: "60"))
        songs.append(Song(name: "Аэропорт",
                          albumName: "Elena_Vaenga",
                          artistName: "",
                          imageName: "60",
                          trackName: "61"))
        songs.append(Song(name: "Курю",
                          albumName: "Elena_Vaenga",
                          artistName: "",
                          imageName: "60",
                          trackName: "62"))
        songs.append(Song(name: "Королева",
                          albumName: "Elena_Vaenga",
                          artistName: "",
                          imageName: "60",
                          trackName: "63"))
        songs.append(Song(name: "Желаю",
                          albumName: "Elena_Vaenga",
                          artistName: "",
                          imageName: "61",
                          trackName: "64"))
        songs.append(Song(name: "Шопен",
                          albumName: "Elena_Vaenga",
                          artistName: "",
                          imageName: "60",
                          trackName: "65"))
        
        songs.append(Song(name: "Тайга",
                          albumName: "Elena_Vaenga",
                          artistName: "",
                          imageName: "61",
                          trackName: "66"))
        
        //90 -e
         //150 Комбинация
         songs.append(Song(name: "A_ya_lyublyu_voennykh",
                           albumName: "",
                           artistName: "Комбинация",
                           imageName: "150",
                           trackName: "151"))
         songs.append(Song(name: "Kombinaciya_-_American_Boy",
                           albumName: "",
                           artistName: "Комбинация",
                           imageName: "150",
                           trackName: "152"))
         songs.append(Song(name: "Bukhgalter",
                           albumName: "",
                           artistName: "Комбинация",
                           imageName: "151",
                           trackName: "153"))
         songs.append(Song(name: "Dva_kusocheka_kolbaski",
                           albumName: "",
                           artistName: "Комбинация",
                           imageName: "150",
                           trackName: "154"))
         songs.append(Song(name: "Pojjdjom_so_mnojj",
                           albumName: "",
                           artistName: "Комбинация",
                           imageName: "151",
                           trackName: "155"))
         songs.append(Song(name: "Serjoga",
                           albumName: "",
                           artistName: "Комбинация",
                           imageName: "150",
                           trackName: "156"))
         songs.append(Song(name: "Vishnjovaya_devyatka",
                           albumName: "",
                           artistName: "Комбинация",
                           imageName: "151",
                           trackName: "157"))
         songs.append(Song(name: "Американ Бой",
                           albumName: "",
                           artistName: "Комбинация",
                           imageName: "153",
                           trackName: "158"))
         //160 Ласковый май
         songs.append(Song(name: "Belye_rozy",
                           albumName: "",
                           artistName: "Ласковый Май",
                           imageName: "160",
                           trackName: "161"))
         songs.append(Song(name: "Glupye_snezhinki",
                           albumName: "",
                           artistName: "Ласковый Май",
                           imageName: "161",
                           trackName: "162"))
         songs.append(Song(name: "Sedaya_noch",
                           albumName: "",
                           artistName: "Ласковый Май",
                           imageName: "162",
                           trackName: "163"))
      
            return songs
      }
}
