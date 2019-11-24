//
//  Photograph.swift
//  PhotographListApp
//
//  Created by Marcus Vinicius Galdino Medeiros on 23/11/19.
//  Copyright © 2019 Marcus Vinicius Galdino Medeiros. All rights reserved.
//

import Foundation

public struct Photograph: Decodable{
    let id:String
    let author:String
    let width:Int
    let height:Int
    let url:String
    let download_url:String
}
