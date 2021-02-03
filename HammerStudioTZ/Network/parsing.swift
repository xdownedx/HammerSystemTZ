//
//  parsing.swift
//  HammerStudioTZ
//
//  Created by Максим Палёхин on 31.01.2021.
//

import Foundation

struct ParsingData {
  
    var onCompletion: ((Array<Auto>)->Void)?

    func broadcastData(){
        let urlString="https://raw.githubusercontent.com/xdownedx/jsonForTz/main/result.json"
        guard let url=URL(string: urlString) else {
            return
        }
        let session=URLSession(configuration: .default)
        let task = session.dataTask(with: url){data, response, error in
            if let data=data{
            print(data)
                if let resultParse=parseJSON(with: data){
                    DispatchQueue.main.async(execute: {
                                                self.onCompletion?(resultParse)
                    })
                }
            }
        }
        task.resume()
        return
    }

    func parseJSON(with dataFromGit:Data)->Array<Auto>?{
        var autoData = Array<Auto>()
        let decoder = JSONDecoder()
        do {
            let result = try decoder.decode(data.self, from: dataFromGit)
            for item in result.result{
                autoData.append(Auto(autoData: item))
                
            }
            return autoData
        } catch let error as NSError{
            print(error)
            return nil
        }
    }
}
