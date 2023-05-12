//
//  PlayerViewController.swift
//  myMusic
//
//  Created by  Сергей on 27.07.2022.
//

import UIKit
import AVFoundation
import AVKit

class PlayerViewController: UIViewController, AVAudioPlayerDelegate  {
    
    public var position : Int = 0
    public var songs:[Song] = []
    public var sliderTrack = UISlider()
    private let holder = UIView()
    public var player = AVAudioPlayer()
    private var timer = Timer()
    
    //элементы пользовательского интерфейса
    
    private let albumImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill//.scaleAspectFit//.scaleAspectFill
        imageView.layer.cornerRadius = 35
        imageView.layer.masksToBounds = true
        imageView.layer.shadowOpacity = 0.7
        imageView.layer.shadowRadius = 5
        //  imageView.layer.borderWidth = 2
        return imageView
    }()
    
    private let songNameLable: UILabel = {
        let lable = UILabel()
        lable.textAlignment = .center
        lable.numberOfLines = 0// позволяет переносить строку
        lable.font = UIFont(name: "Helvetica-Bold", size: 28)
        return lable
    }()
    
    private let artistNameLable: UILabel = {
        let lable = UILabel()
        lable.textAlignment = .center
        lable.numberOfLines = 0 // позволяет переносить строку да хрен там
        lable.font = UIFont(name: "Helvetica", size: 18)
        return lable
    }()
    
    private let albumNameLable: UILabel = {
        let lable = UILabel()
        lable.textAlignment = .center
        lable.numberOfLines = 0 // позволяет переносить строку
        return lable
    }()
    
    let playerPauseButton = UIButton ()
    
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
        if holder.subviews.count == 0 { // хер знает что это значит количестов подпросотров ?
            configure()
        }
        view.addSubview(holder)
        
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
    private func   configure() {
        /// настройка плеера
        let song = songs[position] // position это типа индекс или id или как в массиве можно по имени перебирать данные а можно по индексу
        //путь к файлу произведения
        let urlString = Bundle.main.path(forResource: song.trackName, ofType: "mp3")
        DispatchQueue.main.async { [weak self] in
            do {
                ///настройка режимов
                try AVAudioSession.sharedInstance().setCategory(.playback)// это чтобы в фоне работало
                try AVAudioSession.sharedInstance().setMode(.default)
                try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
                guard let urlString = urlString else {return}
                self?.player = try AVAudioPlayer(contentsOf: URL(string: urlString)!)
                self?.player.volume = 0.5 // устанавливаем уровень звука по умолчанию
                self?.player.play()
                self?.player.delegate = self //делегат работает тут где создается проигрыватель в других емстах он не видит себя
                //пробуем таймер
                self?.createTimer()
            }
            catch {
                print("Ошибка воспроизведения")
            }
        }
        
        
        /// настройка пользовательского интерфейса
        albumImageView.frame = CGRect(x: 10,
                                      y: 10,
                                      width: holder.frame.size.width - 20,
                                      height: holder.frame.size.width - 20)
        
        
        albumImageView.image = UIImage(named: song.imageName)
        holder.addSubview(albumImageView)
        
        /// настройка лейблов  их порядок сначало название песни потом исполнитель потом альбом
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
        
        ///настройка лейблов
        holder.addSubview(songNameLable)
        holder.addSubview(artistNameLable)
        holder.addSubview(albumNameLable)
        
        songNameLable.text = song.name
        artistNameLable.text = song.artistName
        albumNameLable.text = song.albumName
        
        ///настройка плеера его элементов управления
        
        let playerNextButton = UIButton ()
        let playerBackButton = UIButton ()
        
        
        ///изображение кнопок
        playerPauseButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
        playerNextButton.setBackgroundImage(UIImage(systemName: "forward.fill"), for: .normal)
        playerBackButton.setBackgroundImage(UIImage(systemName: "backward.fill"), for: .normal)
        
        
        ///добавляем на вью
        holder.addSubview(playerPauseButton)
        holder.addSubview(playerNextButton)
        holder.addSubview(playerBackButton)
        
        
        ///цвет кнопки
        playerPauseButton.tintColor = .blue
        playerNextButton.tintColor = .blue
        playerBackButton.tintColor = .blue
        
        
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
    @objc func didSliderSlider (_ slider: UISlider) {
        let value = slider.value
        player.volume = value
        
    }
    
    ///перемотка клипа
    @objc func didSliderTrack (_ sliderTrack: UISlider) {
        let maxValue = player.duration
        sliderTrack.maximumValue = Float(maxValue)
        sliderTrack.minimumValue = 0.0
        let value = sliderTrack.value
        player.currentTime = Double(value)
        player.play()
    }
    
    ///дейстиве кнопок плеера
    @objc func didTapPlayerPauseButton (){
        if player.isPlaying == true{
            //pause
            player.pause()
            playerPauseButton.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
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
            playerPauseButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
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
    @objc func didTapPlayerNextButton (){
        if position < (songs.count - 1) {
            print(position)
            position = position + 1
            player.stop()
            // это  то же связанно с подвидами незнаю пока для чего это если без этого то слайер оставляет что то вроеде старое значение ввиде своей тени
            for subview in holder.subviews {
                subview.removeFromSuperview()
            }
            configure()
        }
    }
    
    @objc func didTapPlayerBackButton (){
        if position > 0 {
            position = position - 1
            player.stop()
            // это  то же связанно с подвидами незнаю пока для чего это
            for subview in holder.subviews {
                subview.removeFromSuperview()
            }
            configure()
        }
    }
    
    //когда вью исчезает
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //if let player = player { //если пользователь закроет контроллер то проигрывание музыки остановиться
        player.stop() // нафиг не нужен когда контроллер закрывется плеер останавливаеся сам
        //    }
    }
    
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
