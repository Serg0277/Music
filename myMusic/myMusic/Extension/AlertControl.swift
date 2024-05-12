//
//  AlertControl.swift
//  myMusic
//
//  Created by  Сергей on 11.05.2024.
//

import Foundation
import UIKit

class Alert {
    
    static let shared = Alert()
    /// функция срабатывает когда возникает ошибка заполнения полей
    public func alertLoadFileError () -> UIAlertController{
        let alert = UIAlertController(title: "Woops",
                                      message: "Загрузить файл не удалось, возможно, его просто забыли вставить в поле 😂?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Отменить", style: .cancel, handler: nil))
        return alert
    }
}
