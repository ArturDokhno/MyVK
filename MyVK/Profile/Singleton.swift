//
//  Singleton.swift
//  10l_ArturDokhno
//
//  Created by Артур Дохно on 01.10.2021.
//

import UIKit

class Singleton {
    
    static let shared = Singleton()
    
    private init() { }
    
    var nameUser = ""
    var ageUser = ""
    var cityUser = ""
    
    var token: String = ""
    var userID: Int = 0
    
}

