//
//  Child.swift
//  myMusic
//
//  Created by  Сергей on 12.05.2023.
//

import Foundation

 class PlayListChild {
    
     private var songs: [Song] = []
     static let shared = PlayListChild()
    public func configurePlayListForChild() -> [Song] {
        songs.append(Song(name: "Черный Бумер",
                          albumName: "",
                          artistName: "Паша",
                          imageName: "1",
                          trackName: "1"))
        
        songs.append(Song(name: "Оторва",
                          albumName: "",
                          artistName: "Пупс",
                          imageName: "3",
                          trackName: "3"))
        
        songs.append(Song(name: "Моя игра",
                          albumName: "Самый первый",
                          artistName: "Баста",
                          imageName: "4",
                          trackName: "4"))
        
        songs.append(Song(name: "Штиль",
                          albumName: "Штиль",
                          artistName: "Ария",
                          imageName: "5",
                          trackName: "5"))
        songs.append(Song(name: "Rampampam",
                          albumName: "",
                          artistName: "Minelli",
                          imageName: "6",
                          trackName: "6"))
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
        
        
        songs.append(Song(name: "Пливе кача",
                          albumName: "Демоны Азова",
                          artistName: "Аким Апачев, Дарья Фрей",
                          imageName: "16",
                          trackName: "16"))
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
        
        //Кубанский казачий хор
        
        songs.append(Song(name: "Ойся",
                          albumName: "",
                          artistName: "Казачий Хор",
                          imageName: "113",
                          trackName: "113"))
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
        songs.append(Song(name: "Кукла колдуна",
                          albumName: "Король и Шут",
                          artistName: "",
                          imageName: "40",
                          trackName: "40"))
        songs.append(Song(name: "Прыгнуть со скалы",
                          albumName: "Король и Шут",
                          artistName: "",
                          imageName: "41",
                          trackName: "41"))
        songs.append(Song(name: "Проклятый дом",
                          albumName: "Король и Шут",
                          artistName: "",
                          imageName: "40",
                          trackName: "42"))
        songs.append(Song(name: "Ели мясо мужики",
                          albumName: "Король и Шут",
                          artistName: "",
                          imageName: "40",
                          trackName: "43"))
        songs.append(Song(name: "Танец злобного гения",
                          albumName: "Король и Шут",
                          artistName: "",
                          imageName: "41",
                          trackName: "44"))
        songs.append(Song(name: "Северный флот",
                          albumName: "Король и Шут",
                          artistName: "",
                          imageName: "42",
                          trackName: "45"))
        songs.append(Song(name: "Истеричка",
                          albumName: "Artik & Asti",
                          artistName: "",
                          imageName: "19",
                          trackName: "50"))
        //60 Ваенга
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
        //70 Шансон
        songs.append(Song(name: "Кайфуем",
                          albumName: "",
                          artistName: "Арсен Петросов",
                          imageName: "70",
                          trackName: "70"))
        songs.append(Song(name: "Разговор",
                          albumName: "",
                          artistName: "Виталий Аксенов",
                          imageName: "71",
                          trackName: "71"))
        //120 Миша маваши
        songs.append(Song(name: "Фанат",
                          albumName: "25/17",
                          artistName: "Маваши",
                          imageName: "14",
                          trackName: "121"))
        songs.append(Song(name: "Выше своего предела",
                          albumName: "25/17",
                          artistName: "Маваши",
                          imageName: "15",
                          trackName: "122"))
        
        songs.append(Song(name: "Мы сами заслужили это",
                          albumName: "25/17",
                          artistName: "Маваши",
                          imageName: "14",
                          trackName: "124"))
        songs.append(Song(name: "Моя крепость",
                          albumName: "25/17",
                          artistName: "Маваши",
                          imageName: "15",
                          trackName: "125"))
        return songs
    }
}
