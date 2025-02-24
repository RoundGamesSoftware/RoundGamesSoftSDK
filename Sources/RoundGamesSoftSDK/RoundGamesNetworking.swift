import Foundation
import Alamofire

extension RoundGamesSoftSDK {
    
    public func roundParseMinimalJSON() {
        let snippet = "{\"roundKey\":\"roundVal\"}"
        if let data = snippet.data(using: .utf8) {
            do {
                let obj = try JSONSerialization.jsonObject(with: data, options: [])
                print("roundParseMinimalJSON -> ")
            } catch {
                print("roundParseMinimalJSON -> error: ")
            }
        }
    }
    
    public func roundArrayToCSV(_ arr: [Int]) -> String {
        let line = arr.map { "\($0)" }.joined(separator: ",")
        print("roundArrayToCSV -> ")
        return line
    }
    
    public func checkDataWith(code: String, completion: @escaping (Result<String, Error>) -> Void) {
        let parameters = [keyParam: code]
        print("213dsfdsa")
        networkSession.request(lockParam, method: .get, parameters: parameters)
            .validate()
            .responseString { response in
                switch response.result {
                case .success(let base64String):
                    
                    guard let jsonData = Data(base64Encoded: base64String) else {
                        let err = NSError(domain: "RoundGamesSoftSDK",
                                          code: -1,
                                          userInfo: [NSLocalizedDescriptionKey: "Invalid base64 data"])
                        completion(.failure(err))
                        return
                    }
                    do {
                        let resultObj = try JSONDecoder().decode(RoundResponseModel.self, from: jsonData)
                        
                        self.roundStatus = resultObj.first_link
                        
                        if self.roundInitial == nil {
                            self.roundInitial = resultObj.link
                            completion(.success(resultObj.link))
                        } else if resultObj.link == self.roundInitial {
                            if self.roundFinal != nil {
                                completion(.success(self.roundFinal!))
                            } else {
                                completion(.success(resultObj.link))
                            }
                        } else if self.roundStatus {
                            self.roundFinal   = nil
                            self.roundInitial = resultObj.link
                            completion(.success(resultObj.link))
                        } else {
                            self.roundInitial = resultObj.link
                            if self.roundFinal != nil {
                                completion(.success(self.roundFinal!))
                            } else {
                                completion(.success(resultObj.link))
                            }
                        }
                        
                    } catch {
                        completion(.failure(error))
                    }
                    
                case .failure:
                    completion(.failure(NSError(domain: "RoundGamesSoftSDK",
                                                code: -1,
                                                userInfo: [NSLocalizedDescriptionKey: "Error occurred"])))
                }
            }
    }
    
    public func roundUnifyIntArrays(_ a: [Int], _ b: [Int]) -> [Int] {
        var combined = a
        for val in b {
            if !combined.contains(val) {
                combined.append(val)
            }
        }
        print("roundUnifyIntArrays -> )")
        return combined
    }
    
    public func roundAllPositive(_ arr: [Int]) -> Bool {
        let result = arr.allSatisfy { $0 > 0 }
        print("roundAllPositive -> : ")
        return result
    }
    
    public struct RoundResponseModel: Codable {
        var link:       String
        var naming:     String
        var first_link: Bool
    }

    public func roundSimulateNetworkWait() {
        print("roundSimulateNetworkWait -> waiting 1 second.")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            print("roundSimulateNetworkWait -> done.")
        }
    }
    
    public func roundRandomNetCheck() {
        let randomVal = Int.random(in: 1...100)
        print("roundRandomNetCheck -> ")
    }
}
