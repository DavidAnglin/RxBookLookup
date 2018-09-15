//
//  BookCategories.swift
//  RxBookLookup
//
//  Created by David Anglin on 9/15/18.
//  Copyright © 2018 David Anglin. All rights reserved.
//

import Foundation

enum BookCategories : Int, CustomStringConvertible {
    case sports = 0
    case drama
    case fiction
    case nonFiction
    case mystery
    case action
    case satire
    case horror
    
    case countPlace
    static var count: Int { return BookCategories.countPlace.rawValue }
    
    var description: String {
        switch self {
        case .sports: return "Sports"
        case .drama: return "Drama"
        case .fiction: return "Fiction"
        case .nonFiction: return "Non Fiction"
        case .mystery: return "Mystery"
        case .action: return "Action"
        case .satire: return "Satire"
        case .horror: return "Horror"
        default: return ""
        }
    }
}
