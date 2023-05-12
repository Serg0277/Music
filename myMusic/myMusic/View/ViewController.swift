//
//  ViewController.swift
//  myMusic
//
//  Created by  Сергей on 27.07.2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    public var songs = [Song]()
    
    let myTable : UITableView = {
        let table = UITableView()
        table.register(myTableViewCell.self,
                       forCellReuseIdentifier: myTableViewCell.identifier) // регистрация ячейки она у нас  отдельным файлом
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSoungs() // функция объектов песен
        myTable.frame = view.bounds
        myTable.dataSource = self
        myTable.delegate = self
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.addSubview(myTable)
    }
    
    func  configureSoungs() {
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
        songs.append(Song(name: "Ой Дуся ой Маруся",
                          albumName: "",
                          artistName: "Казачий Хор",
                          imageName: "113",
                          trackName: "111"))
        songs.append(Song(name: "Ойся",
                          albumName: "",
                          artistName: "Казачий Хор",
                          imageName: "113",
                          trackName: "113"))
        songs.append(Song(name: "Не для меня",
                          albumName: "",
                          artistName: "Казачий Хор",
                          imageName: "113",
                          trackName: "112"))
        songs.append(Song(name: "Казацкая лезгинка",
                          albumName: "",
                          artistName: "Казачий Хор",
                          imageName: "113",
                          trackName: "114"))
        songs.append(Song(name: "Когда мы были на войне",
                          albumName: "",
                          artistName: "Казачий Хор",
                          imageName: "113",
                          trackName: "115"))
        songs.append(Song(name: "Ой при лужке",
                          albumName: "",
                          artistName: "Казачий Хор",
                          imageName: "113",
                          trackName: "116"))
        
        //Сектор газа
        //        songs.append(Song(name: "Бомж",
        //                          albumName: "Сектор Газа",
        //                          artistName: "Сектор Газа",
        //                          imageName: "20",
        //                          trackName: "20"))
        //
        //        songs.append(Song(name: "Лирика",
        //                          albumName: "Сектор Газа",
        //                          artistName: "Сектор Газа",
        //                          imageName: "20",
        //                          trackName: "22"))
        //        songs.append(Song(name: "Ява",
        //                          albumName: "Сектор Газа",
        //                          artistName: "Сектор Газа",
        //                          imageName: "20",
        //                          trackName: "23"))
        //        songs.append(Song(name: "Демобилизация",
        //                          albumName: "Сектор Газа",
        //                          artistName: "Сектор Газа",
        //                          imageName: "20",
        //                          trackName: "24"))
        //        songs.append(Song(name: "Туман",
        //                          albumName: "Сектор Газа",
        //                          artistName: "Сектор Газа",
        //                          imageName: "20",
        //                          trackName: "25"))
        //        songs.append(Song(name: "Казачья",
        //                          albumName: "Сектор Газа",
        //                          artistName: "Сектор Газа",
        //                          imageName: "20",
        //                          trackName: "26"))
        //        songs.append(Song(name: "Частушки",
        //                          albumName: "Сектор Газа",
        //                          artistName: "Сектор Газа",
        //                          imageName: "20",
        //                          trackName: "27"))
        //        songs.append(Song(name: "Еду бабу выручать",
        //                         albumName: "Сектор Газа",
        //                          artistName: "Сектор Газа",
        //                          imageName: "20",
        //                          trackName: "28"))
        //       //Зиверт
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
        //80 Круг
        songs.append(Song(name: "Напиши мне",
                          albumName: "",
                          artistName: "Ирина Круг",
                          imageName: "80",
                          trackName: "80"))
        songs.append(Song(name: "Владимирский централ",
                          albumName: "",
                          artistName: "Михаил Круг",
                          imageName: "80",
                          trackName: "81"))
        songs.append(Song(name: "Падал Снег",
                          albumName: "",
                          artistName: "Михаил Круг",
                          imageName: "81",
                          trackName: "82"))
        
        songs.append(Song(name: "Падал Снег",
                          albumName: "",
                          artistName: "Михаил Круг",
                          imageName: "80",
                          trackName: "82"))
        songs.append(Song(name: "Приходите В Мой Дом",
                          albumName: "",
                          artistName: "Михаил Круг",
                          imageName: "80",
                          trackName: "83"))
        songs.append(Song(name: "Тебе, Моя Последняя Любовь",
                          albumName: "",
                          artistName: "Михаил Круг",
                          imageName: "81",
                          trackName: "84"))
        songs.append(Song(name: "Только для тебя",
                          albumName: "",
                          artistName: "Михаил Круг",
                          imageName: "81",
                          trackName: "85"))
        //90 Высоцкий
        songs.append(Song(name: "Дом хрустальный",
                          albumName: "",
                          artistName: "Владимир Высоцкий",
                          imageName: "90",
                          trackName: "90"))
        songs.append(Song(name: "Здесь вам не равнина",
                          albumName: "",
                          artistName: "Владимир Высоцкий",
                          imageName: "91",
                          trackName: "91"))
        songs.append(Song(name: "Песня О Друге",
                          albumName: "",
                          artistName: "Владимир Высоцкий",
                          imageName: "92",
                          trackName: "92"))
        songs.append(Song(name: "Спасите наши души",
                          albumName: "",
                          artistName: "Владимир Высоцкий",
                          imageName: "90",
                          trackName: "93"))
        songs.append(Song(name: "Утренняя Гимнастика",
                          albumName: "",
                          artistName: "Владимир Высоцкий",
                          imageName: "91",
                          trackName: "94"))
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
        //130
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
        return 90
    }
    
    
}


