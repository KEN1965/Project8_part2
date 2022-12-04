//
//  Bundle-Decodable.swift
//  Project8_part2
//
//  Created by K.Takahama on R 4/12/03.
//

import Foundation

//jsonファイルを扱えるように・・
//missions.jsonファイルを扱えるように・・

extension Bundle {
    //①プロジェクト内にある"astronauts"のパス取得
    //T:タイプのTでコーディングの慣例（Type/TypeOfThing/Fishなどと買いても可）
    func decode<T: Codable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        //ファイルが読み込まれないエラーが起きている
        
    //②astronautsファイルの内容をdata:Dataに読み込み
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }
        
    //③デコードしていきます
        let decoder = JSONDecoder()
        
        //日付のフォーマット
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }
        
        return loaded
    }
    
}
