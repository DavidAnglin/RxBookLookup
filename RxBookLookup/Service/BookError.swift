//
//  BookError.swift
//  RxBookLookup
//
//  Created by David Anglin on 9/15/18.
//  Copyright © 2018 David Anglin. All rights reserved.
//

import Foundation

enum BookError: Error {
    case invalidParameter(String, Any)
    case invalidURL(String)
    case invalidJSON(String)
}
