//
//  DetailItemModel.swift
//  FeedLayout
//
//  Created by N.A Shashank on 15/10/18.
 
//

import UIKit
import MobileCoreServices

final class DetailItemModel:NSObject,NSItemProviderWriting,NSItemProviderReading,Codable {
    
    static var writableTypeIdentifiersForItemProvider: [String]{
        return [(kUTTypeData as String)]
    }
    
    static var readableTypeIdentifiersForItemProvider: [String]{
        return [(kUTTypeData as String)]
    }
    
    let title:String
    
    init(title:String) {
      self.title = title
    }
    
    func loadData(withTypeIdentifier typeIdentifier: String, forItemProviderCompletionHandler completionHandler: @escaping (Data?, Error?) -> Void) -> Progress? {
        let progress = Progress(totalUnitCount: 100)
        do {
            let data = try JSONEncoder().encode(self)
            progress.completedUnitCount = 100
            completionHandler(data,nil)
        }
        catch {
            completionHandler(nil,error)
        }
        return progress
    }
    
    static func object(withItemProviderData data: Data, typeIdentifier: String) throws -> DetailItemModel {
        do {
            let subject = try JSONDecoder().decode(DetailItemModel.self, from: data)
            return subject
        }
        catch{
            fatalError("\(error.localizedDescription)")
        }
    }
    
}
