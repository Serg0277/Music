//
//  ManagerLoaderViewController.swift
//  myMusic
//
//  Created by  Сергей on 04.05.2024.
//

import UIKit
import AVFAudio
import JGProgressHUD
//import MobileCoreServices //это для типа файлов чтоб различал
import AVFoundation //для метаданных

class ManagerLoaderViewController: UIViewController {
    public var songs : [SongUrl] = []
    public var position = 0
    public var musicUrl : [URL] = []
    private var player = AVAudioPlayer()
    private var spinner  = JGProgressHUD(style: .dark)
   
    private let myTable : UITableView = {
        let table = UITableView()
        table.register(ManagerTableViewCell.self,
                       forCellReuseIdentifier: ManagerTableViewCell.identifier)
        return table
    }()
    private let loaderURLTextField : UITextField = {
        let tf = UITextField()
        tf.placeholder = "Вставте ссылку на файл"
        tf.autocapitalizationType = .none //заглавные буквы нет
        tf.autocorrectionType = .no //автокорекция нет
        tf.returnKeyType = .continue // точка ключа продолжить на клавиатуре возврат а  в пароль
        tf.layer.cornerRadius = 12
        tf.layer.borderColor = UIColor.systemGroupedBackground.cgColor
        tf.layer.borderWidth = 1
        //эта фишечка отступ от края поля все три настрйки нужны
        tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        tf.leftViewMode = .always
        tf.backgroundColor = .secondarySystemBackground//.white
        return tf
        
    }()
    
    private let downLoadButtom: UIButton = {
        let bt = UIButton(type: .system)
        bt.setTitle("Загрузить файл", for: .normal)
        bt.backgroundColor = .systemGreen
        bt.setTitleColor( .white, for: .normal) // цвет заголовка
        bt.layer.cornerRadius = 12 // закругленные углы
        bt.layer.masksToBounds = true // маскировка границы отсиает лишнее
        bt.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold) // заголовок жирный
        return bt
    }()
    
    private let playButtom: UIButton = {
        let bt = UIButton(type: .system)
        bt.setTitle("Play", for: .normal)
        bt.backgroundColor = .systemGreen
        bt.setTitleColor( .white, for: .normal) // цвет заголовка
        bt.layer.cornerRadius = 12 // закругленные углы
        bt.layer.masksToBounds = true // маскировка границы отсиает лишнее
        bt.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold) // заголовок жирный
        return bt
    }()
    private let importFileButtom: UIButton = {
        let bt = UIButton(type: .system)
        bt.setTitle("Import File", for: .normal)
        bt.backgroundColor = .systemGreen
        bt.setTitleColor( .white, for: .normal) // цвет заголовка
        bt.layer.cornerRadius = 12 // закругленные углы
        bt.layer.masksToBounds = true // маскировка границы отсиает лишнее
        bt.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold) // заголовок жирный
        return bt
    }()
    private let playerNextButton = UIButton (type: .system)
    private let playerBackButton = UIButton (type: .system)
    
 
   
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        super.viewDidLoad()
        setupView()
        configMusicContent()
      
        myTable.dataSource = self
        myTable.delegate = self
        }
    
    private func  setupView(){
        playerNextButton.setBackgroundImage(UIImage(systemName: "forward.fill"), for: .normal)
        playerBackButton.setBackgroundImage(UIImage(systemName: "backward.fill"), for: .normal)
        view.addSubview(loaderURLTextField)
        view.addSubview(downLoadButtom)
        view.addSubview(playButtom)
        view.addSubview(importFileButtom)
        view.addSubview(playerNextButton)
        view.addSubview(playerBackButton)
        view.addSubview(myTable)
        playerBackButton.addTarget(self, action: #selector(didTapPlayerBackButton), for: .touchUpInside)
        playerNextButton.addTarget(self, action: #selector(didTapPlayerNextButton), for: .touchUpInside)
        downLoadButtom.addTarget(self, action: #selector(tapLoadButton), for: .touchUpInside)
        playButtom.addTarget(self, action: #selector(tapPlayButton), for: .touchUpInside)
        importFileButtom.addTarget(self, action: #selector(openDocumentPicker), for: .touchUpInside)
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
            myTable.reloadData()
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
    
    @objc private func tapLoadButton(){
        guard let textUrl = loaderURLTextField.text else {return}
        if !textUrl.isEmpty {
            spinner.show(in: view)
            guard let urlString = loaderURLTextField.text else {return}
            guard let sourseUrl = URL(string: urlString) else {return}
            let urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue())
            let downLoadTask = urlSession.downloadTask(with: sourseUrl)
            downLoadTask.resume()
        }else{
            let alert = Alert.shared.alertLoadFileError()
            present(alert, animated: true)
        }
    }
    
    //открытие пикера
    @objc  private func openDocumentPicker() {
        let documentPicer = UIDocumentPickerViewController(forOpeningContentTypes: [.mp3], asCopy: true)
        documentPicer.delegate = self
        documentPicer.allowsMultipleSelection = false//выбрать один файл
        present(documentPicer, animated: true, completion: nil)
    }
    
    @objc private func  tapPlayButton() {
        //пытаюсь достать метаданные
        
        //вот до сюда
        DispatchQueue.main.async { [weak self] in
            do {
                ///настройка режимов
                try AVAudioSession.sharedInstance().setCategory(.playback)// это чтобы в фоне работало
                try AVAudioSession.sharedInstance().setMode(.default)
                try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
               
                guard let musicUrl = self?.songs, let position = self?.position else {return}
                guard let musicPlay = musicUrl[position].trackName else {
                    return
                }
                //URL(string:"file:///var/mobile/media/Music/1.mp3")
               // self?.player = try AVAudioPlayer(contentsOf: URL(string: urlString)!)
                self?.player = try AVAudioPlayer(contentsOf: musicPlay)
                self?.player.volume = 1.0 // устанавливаем уровень звука по умолчанию
                self?.player.play()
                
                self?.player.delegate = self //делегат работает тут где создается проигрыватель в других емстах он не видит себя
            }
            catch {
                print("Ошибка воспроизведения- \(error.localizedDescription)")
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        loaderURLTextField.frame = CGRect(x: 10, y: navigationItem.titleView?.frame.maxY ?? 100, width: view.width - 20, height: 45)
        downLoadButtom.frame = CGRect(x: 10, y: loaderURLTextField.frame.maxY + 30, width: view.width - 20, height: 32)
        
        importFileButtom.frame = CGRect(x: 10, y: downLoadButtom.frame.maxY + 10, width: view.width - 20, height: 32)
        myTable.frame = CGRect(x: 0, y: importFileButtom.bottom + 20, width: view.width, height: view.height * 0.7)
        
    /*    playButtom.frame = CGRect(x: view.width/2  - 70, y: importFileButtom.frame.maxY + 10, width: 140, height: 32)
      
        playerBackButton.frame = CGRect(x: 10, y: importFileButtom.frame.maxY + 10, width: 53, height: 32)
        playerNextButton.frame = CGRect(x: view.frame.width - 53 - 10, y: importFileButtom.frame.maxY + 10, width: 53, height: 32)
     */
    }
    
    //когда вью исчезает
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //if let player = player { //если пользователь закроет контроллер то проигрывание музыки остановиться
        player.stop() // нафиг не нужен когда контроллер закрывется плеер останавливаеся сам
        //    }
    }
    //кнопка следующая песня
    @objc private func didTapPlayerNextButton (){
        if position < (musicUrl.count - 1) {
            print(position)
            position = position + 1
            player.stop()
            // это  то же связанно с подвидами незнаю пока для чего это если без этого то слайер оставляет что то вроеде старое значение ввиде своей тени
         //   for subview in holder.subviews {
         //       subview.removeFromSuperview()
           // }
            tapPlayButton()
        }else{
            print(position)
            print(musicUrl.count)
        }
    }
    
    @objc private func didTapPlayerBackButton (){
        if position > 0 {
            position = position - 1
            player.stop()
            // это  то же связанно с подвидами незнаю пока для чего это
       //     for subview in holder.subviews {
         //       subview.removeFromSuperview()
           // }
            tapPlayButton()
        }
    }
}
//делегат URLSessionDownloadDelegate перехватывает загружаемый файл  можно и без него в приложении filemanager
extension ManagerLoaderViewController: URLSessionDownloadDelegate {
    //метод
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        
        print("это URL который из location tmp папка - \(location)") //адрес места на диске куда сохранилось временный файл
        
        guard let url = downloadTask.originalRequest?.url else {return} //это то что скачали
        print("это адрес который из downloadTask то что скачали - \(url)")
        let musicPatch = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0] // это адрес по дефолту нашего приложения
        print("это URL который из FileManager это адрес папки нашего приложения - \(musicPatch.absoluteString)")
        let destinationPatch = musicPatch.appendingPathComponent(url.lastPathComponent) //("Король и шут.mp3")//(url.lastPathComponent)
        //lastPathComponent - последний компонент пути без слеша
        print("это URL в который мы поидее добавили наш файл - \(destinationPatch)")
        try? FileManager.default.removeItem(at: destinationPatch)//удаляем на всякий случай
        do {//копируем то что скачалось в соотвествующую директорию
            try FileManager.default.copyItem(at: location, to: destinationPatch)
            print("это location - \(location.absoluteString)")
            self.spinner.dismiss(animated: true)
            self.configMusicContent()
        }catch let error{
            print("Copy Error - \(error.localizedDescription)")
            self.spinner.dismiss(animated: true)
        }
    }
}
//delegate AVAudioPlayer
extension ManagerLoaderViewController:  AVAudioPlayerDelegate{
  
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool){
        if flag == true, position < musicUrl.count - 1  {
            print("Закончилось воспроизведение позиции: \(position)")
            print("Количество треков: \(musicUrl.count)")
            print("Сработал делегат!")
            didTapPlayerNextButton ()
        } else  {
            print("GAME OVER!")
            position = -1
            didTapPlayerNextButton ()
        }
    }
}
//делегат пикера
//добавление файла в песочницу приложения
extension ManagerLoaderViewController: UIDocumentPickerDelegate{
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
     guard   let selectUrlFile = urls.first else {
            return
        }
        guard let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return}
        let sanboxFileUrl = dir.appendingPathComponent(selectUrlFile.lastPathComponent, conformingTo: .fileURL)
        
        if FileManager.default.fileExists(atPath: sanboxFileUrl.path){
            print("Такой файл уже существует 🤬!")
        }else{
            do{
                try FileManager.default.copyItem(at: selectUrlFile, to: sanboxFileUrl)
                print("Все прошло отлично 😉")
                configMusicContent()
            }
            catch{
                print("шибка записи файла!- \(error.localizedDescription)")
            }
        }
            
    }
}
extension ManagerLoaderViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ManagerTableViewCell.identifier
                                                 , for: indexPath) as! ManagerTableViewCell
        let song = songs[indexPath.row]
        cell.configure(with: song)
        //cell.accessoryType = .disclosureIndicator // вид курсора чтоли
        return cell
    }
    // высота ячейки
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension ManagerLoaderViewController: UITableViewDelegate{
    //выбор ячеки
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //представляем плеер
        position = indexPath.row
        tapPlayButton()
    }
}
