//
//  DataSources.swift
//  AudioBookSample
//
//  Created by Luthfi Abdul Azis on 27/02/21.
//

import Foundation
import Combine

class DataSources {
    func getData() -> Datas {
        
        let jsonString = """
{"history":[{"id":1,"title":"Book of Life","cover":"thumb1","price":30,"author":"John Doe","rate":4.5},{"id":2,"title":"The old man of Canada","cover":"thumb2","price":19.99,"author":"Anna Chris","rate":3.1},{"id":3,"title":"Miracle of the Quran","cover":"thumb3","price":50,"author":"Basheer","rate":5},{"id":4,"title":"Pride and Prejudice","cover":"thumb4","price":20,"author":"Jane Austen","rate":5},{"id":5,"title":"The Lord of the Flies","cover":"thumb5","price":15.99,"author":"William Golding","rate":4},{"id":6,"title":"Farenheit","cover":"thumb6","price":12.5,"author":"Alberto Guzalo","rate":3.1}],"top":[{"id":1,"title":"Pride and Prejudice","cover":"thumb4","price":20,"author":"Jane Austen","rate":5},{"id":2,"title":"The Lord of the Flies","cover":"thumb5","price":15.99,"author":"William Golding","rate":4},{"id":3,"title":"Farenheit","cover":"thumb6","price":12.5,"author":"Alberto Guzalo","rate":3.1},{"id":4,"title":"Book of Life","cover":"thumb1","price":30,"author":"John Doe","rate":4.5},{"id":5,"title":"The old man of Canada","cover":"thumb2","price":19.99,"author":"Anna Chris","rate":3.1},{"id":6,"title":"Miracle of the Quran","cover":"thumb3","price":50,"author":"Basheer","rate":5}]}
"""
        
        let base = jsonString.data(using: .utf8)!
        
        let decode: Datas = try! JSONDecoder().decode(Datas.self, from: base)
        return decode
    }
}
