//
//  PlayerViewController.swift
//  myMusic
//
//  Created by  Сергей on 27.07.2022.
// отдельный контроллер для прослушивания выбранного трека музыки и добавление в плейлист

import UIKit
import AVFoundation
import AVKit

final class PlayMusicViewController: UIViewController, AVAudioPlayerDelegate  {
    
    private var playListName : String?
    private var countPress = 0
    public var position : Int = 0
    public var songs:[SongUrl] = []
    public var sliderTrack = UISlider()
    private let holder = UIView()
    public var player = AVAudioPlayer()
    private var timer = Timer()
    
    
    ///элементы пользовательского интерфейса
    private let albumImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 35
        imageView.layer.masksToBounds = true
        imageView.layer.shadowOpacity = 0.7
        imageView.layer.shadowRadius = 5
        return imageView
    }()
    
    private let songNameLable: UILabel = {
        let lable = UILabel()
        lable.textAlignment = .center
        lable.numberOfLines = 0
        lable.font = UIFont(name: "Helvetica-Bold", size: 28)
        return lable
    }()
    
    private let artistNameLable: UILabel = {
        let lable = UILabel()
        lable.textAlignment = .center
        lable.numberOfLines = 0
        lable.font = UIFont(name: "Helvetica", size: 18)
        return lable
    }()
    
    private let albumNameLable: UILabel = {
        let lable = UILabel()
        lable.textAlignment = .center
        lable.numberOfLines = 0
        return lable
    }()
    
    private let playerNextButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "nextwind"), for: .normal)
        return button
    }()
    
    private let playerBackButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "rewind"), for: .normal)
        return button
    }()
    
    private let playerPauseButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "stop"), for: .normal)
        return button
    }()
    
    private let playListButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "heart"), for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        holder.frame = view.frame
        view.backgroundColor = .secondarySystemBackground
        ///получаем размер экрана
        let a = Int(view.frame.size.height)
        let b = Int(view.frame.size.width)
        print("Высота экрана = \(a) Ширина экрана = \(b)")
        
        let c = Int(holder.frame.size.height)
        let d = Int(holder.frame.size.width)
        print("Высота holder = \(c) Ширина holder = \(d)")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if holder.subviews.count == 0{
            configureView()
            configurePlayer()
        }
    }
    
    private func createTimer() {
        let maxValue = player.duration
        sliderTrack.maximumValue = Float(maxValue)
        sliderTrack.minimumValue = 0.0
        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                     target: self,
                                     selector: #selector(updateTimer),
                                     userInfo: nil,
                                     repeats: true)
        
    }
    @objc private func updateTimer (){
        sliderTrack.value = Float(player.currentTime)
        // print("Значение плеера: \(Float(player.currentTime))")
        //  print("Значение слайдера: \(sliderTrack.value)")
    }
    
    private func configurePlayer(){
        /// настройка плеера
        let song = songs[position] // position это типа индекс или id или как в массиве можно по имени перебирать данные а можно по индексу
        //путь к файлу произведения
        let urlString = song.trackName
        //   Bundle.main.path(forResource: song.trackName, ofType: "mp3")
        
        //вот до сюда
        DispatchQueue.main.async { [weak self] in
            do {
                ///настройка режимов
                try AVAudioSession.sharedInstance().setCategory(.playback)// это чтобы в фоне работало
                try AVAudioSession.sharedInstance().setMode(.default)
                try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
                guard let urlString = urlString else {return}
                self?.player = try AVAudioPlayer(contentsOf:  urlString)
                self?.player.volume = 0.5 // устанавливаем уровень звука по умолчанию
                self?.player.play()
                self?.player.delegate = self //делегат работает тут где создается проигрыватель в других емстах он не видит себя
                //пробуем таймер
                self?.createTimer()
                
                if let dataImage = song.imageData {
                    self?.albumImageView.image = UIImage(data: dataImage)
                }else{
                    self?.albumImageView.image = UIImage(systemName: "music.note.list")
                }
            }
            catch {
                print("Ошибка воспроизведения")
            }
            
        }
        songNameLable.text = song.name
        artistNameLable.text = song.artistName
        albumNameLable.text = song.albumName
    }
    
    private func   configureView() {
        ///добавляем на вью
        view.addSubview(holder)
        holder.addSubview(albumImageView)
        holder.addSubview(songNameLable)
        holder.addSubview(artistNameLable)
        holder.addSubview(albumNameLable)
        holder.addSubview(playListButton)
        holder.addSubview(playerPauseButton)
        holder.addSubview(playerNextButton)
        holder.addSubview(playerBackButton)
        
        /// настройка размеров
        albumImageView.frame = CGRect(x: 10,
                                      y: 10,
                                      width: holder.frame.size.width - 20,
                                      height: holder.frame.size.width - 20)
        
        songNameLable.frame = CGRect(x: 10,
                                     y: albumImageView.frame.size.height + 30,
                                     width: holder.frame.size.width - 20,
                                     height: 50)
        
        albumNameLable.frame = CGRect(x: 10,
                                      y: albumImageView.frame.size.height + 70,
                                      width: holder.frame.size.width - 20,
                                      height: 50)
        
        artistNameLable.frame = CGRect(x: 10,
                                       y: albumImageView.frame.size.height + 110,
                                       width: holder.frame.size.width - 20,
                                       height: 50)
        
        playListButton.frame = CGRect(x: (view.width / 2) - 25,
                                      y:artistNameLable.bottom + 20,
                                      width: 50,
                                      height: 50)
        ///рамка для кнопок
        let yPosition = holder.frame.size.height - 150
        let size:CGFloat = 50 // размер кнопок
        playerPauseButton.frame = CGRect(x: (holder.frame.size.width - size) / 2.0,
                                         y: yPosition,
                                         width: 40,
                                         height: 40)
        playerBackButton.frame = CGRect(x: 20,
                                        y: yPosition,
                                        width: 40,
                                        height: 40)
        playerNextButton.frame = CGRect(x: holder.frame.size.width - size - 20,
                                        y: yPosition,
                                        width: 40,
                                        height: 40)
        
        ///действие для кнопкок
        playerPauseButton.addTarget(self, action: #selector(didTapPlayerPauseButton), for: .touchUpInside)
        playerNextButton.addTarget(self, action: #selector(didTapPlayerNextButton), for: .touchUpInside)
        playerBackButton.addTarget(self, action: #selector(didTapPlayerBackButton), for: .touchUpInside)
        playListButton.addTarget(self, action: #selector(didTapPlayListButton), for: .touchUpInside)
        
        ///слайдер звука настройка
        let slider = UISlider(frame: CGRect(x: holder.frame.size.width - 100,
                                            y: holder.frame.size.height / 1.5,
                                            width: holder.frame.size.width / 3,
                                            height: 50))
        //ориентация на вертикальную 1 вариант
        //slider.transform = slider.transform.rotated(by: CGFloat(0.5 * Float.pi))
        // 2 вариант
        slider.transform = CGAffineTransform(rotationAngle: (CGFloat.pi / (-2)))
        holder.addSubview(slider)
        slider.value = 0.5
        slider.addTarget(self, action: #selector(didSliderSlider(_:)), for: .valueChanged)
        
        ///слайдер перемотка настройка
        sliderTrack = UISlider (frame: CGRect(x: 10,
                                              y: albumImageView.frame.size.height + 10,
                                              width: holder.frame.size.width - 40, height: 50))
        holder.addSubview(sliderTrack)
        sliderTrack.addTarget(self, action: #selector(didSliderTrack(_:)), for: .valueChanged)
    }
    
    ///урвень звука
    @objc private func didSliderSlider (_ slider: UISlider) {
        let value = slider.value
        player.volume = value
    }
    
    ///перемотка клипа
    @objc private func didSliderTrack (_ sliderTrack: UISlider) {
        let maxValue = player.duration
        sliderTrack.maximumValue = Float(maxValue)
        sliderTrack.minimumValue = 0.0
        let value = sliderTrack.value
        player.currentTime = Double(value)
        player.play()
    }
    
    ///дейстиве кнопок плеера
    @objc private func didTapPlayerPauseButton (){
        if player.isPlaying == true{
            //pause
            player.pause()
            playerPauseButton.setImage(UIImage(named: "play"), for: .normal)
            // при постановке на паузу слегка уменьшаем изображение
            UIView.animate(withDuration: 0.5) {
                self.albumImageView.frame = CGRect(x: 30,
                                                   y: 30,
                                                   width: self.holder.frame.size.width - 60,
                                                   height: self.holder.frame.size.width - 60)
            }
            
        }
        else{
            //play
            player.play()
            playerPauseButton.setImage(UIImage(named: "stop"), for: .normal)
            // при нажатии на плеер опять возвращаем изображение
            UIView.animate(withDuration: 0.5) {
                self.albumImageView.frame = CGRect(x: 10,
                                                   y: 10,
                                                   width: self.holder.frame.size.width - 20,
                                                   height: self.holder.frame.size.width - 20)
            }
        }
    }
    
    //кнопка следующая песня
    @objc private func didTapPlayerNextButton (){
        if position < (songs.count - 1) {
            print(position)
            position = position + 1
            player.stop()
            // это  то же связанно с подвидами незнаю пока для чего это если без этого то слайер оставляет что то вроеде старое значение ввиде своей тени так как картинки и другие поля обновляются а слайдер остается поэтому мы его тоже удаляем
            //    for subview in holder.subviews {
            // subview.removeFromSuperview()
            //  }
            configurePlayer()
        }
    }
    
    @objc private func didTapPlayerBackButton (){
        if position > 0 {
            position = position - 1
            player.stop()
            configurePlayer()
        }
    }
    
    //обрабатываем нажатие в теории у нас уже есть плейлист при заргузке контроллера или мы его выбираем где-то а если нет то генерируем название случайным образом или не случайным как настроение будет
    @objc private func didTapPlayListButton(){
        if let playListName = playListName {
            updatePlayList(playListName)
        }else{
            //вот тут перерходим на эран или хз и выбираем имеющиеся плейлисты или создаем новый
            
            let nameList = "PlayList1.json"
            updatePlayList(nameList)
        }
    }
    
    //добавляем или удаляем из плейлиста
    private func updatePlayList(_ namePlatList: String){
        let selectSong = PlayListModel(model: songs[position])
        if countPress % 2 == 0{
   //         PlayListManager.shared.addPlayList(selectPlayListString: namePlatList, song: selectSong)
             print("Добавили композицию в плейлист")
        }else{
   //         PlayListManager.shared.deletePlayList(selectPlayListString: namePlatList, song: selectSong)
               print("Удалили композицию из плейлиста")
        }
        countPress += 1
    }
    
    //когда вью исчезает
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //if let player = player{ //если пользователь закроет контроллер то проигрывание музыки остановиться
        player.stop() // нафиг не нужен когда контроллер закрывется плеер останавливаеся сам
        //}
    }
    
    //это делегат?
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool){
        if flag == true, position < songs.count - 1  {
            print("Закончилось воспроизведение позиции: \(position)")
            print("Количество треков: \(songs.count)")
            print("Сработал делегат!")
            didTapPlayerNextButton ()
        } else  {
            print("GAME OVER!")
            position = -1
            didTapPlayerNextButton ()
        }
    }
}
