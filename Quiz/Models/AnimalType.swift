//
//  AnimalType.swift
//  Quiz
//
//  Created by Андрей on 06.11.2021.
//

enum AnimalType: Character {
    case dog = "🐶"
    case cat = "😺"
    case rabbit = "🐰"
    case turtle = "🐢"
    
    var definition: String {
        switch self {
        case .dog:
            return "Вы чрезвыйчайно активны. Вы окружаете себя теми, кого любите и наслаждаетесь взаимодействием с друзьями."
        case .cat:
            return "Вы бесшабашный, но кроткий. Предпочитаете гулять сами по себе."
        case .rabbit:
            return "Вам нравится все мягкое. Вы здоровы и полны энергии."
        case .turtle:
            return "Вы умнее ваших лет. Фокусируетесь на цели. Вы знаете. что медленные, но упорные всегда выигрывают."
        }
    }
}

