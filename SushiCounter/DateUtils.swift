//
//  DateUtils.swift
//  Cingulo
//
//  Created by Michel Anderson Lutz Teixeira on 16/06/2018.
//  Copyright © 2018 Codigo da Mente Edicao E Comercio De Livros E Testes. All rights reserved.
//

import Foundation
struct DateUtils {
     static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
        return formatter
    }()

    static func dateNow() -> String {
        let date = Date()
        let formatter = DateUtils.formatter
        return formatter.string(from: date)
    }
}
