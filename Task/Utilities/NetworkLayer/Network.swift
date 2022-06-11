//
//  Network.swift
//  Task
//
//  Created by John Doe on 2022-06-08.
//

import Foundation
class Network {
    
    static let shared = Network()
    
    func getResults<M: Codable>(APICase: API,decodingModel: M.Type, completed: @escaping (Result<M,ErorrMessage> ) -> Void) {
        var request : URLRequest = APICase.request

        request.httpMethod = APICase.method.rawValue
       
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error =  error {
                print("❌ Error: ",error)
                completed((.failure(.InvalidData)))
            }
            guard let data = data else {
                print("❌ Error in data: ",data)
                completed((.failure(.InvalidData)))
                return
            }
            
            guard let response =  response  as? HTTPURLResponse ,response.statusCode == 200 else{
                print("❌ Error in response: ",response )
                completed((.failure(.InvalidResponse)))
                return
            }
            let decoder = JSONDecoder()
            do
            {
                
                let results = try decoder.decode(M.self, from: data)
                print("✅ Results: ",results)
                completed((.success(results)))
                
            }catch {
                print(error)
                completed((.failure(.InvalidData)))
            }
            
        }
        task.resume()
    }
    
    
}
