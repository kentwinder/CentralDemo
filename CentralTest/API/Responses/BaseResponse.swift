//
//  BaseResponse.swift
//  CentralTest
//
//  Created by Kent Winder on 10/14/20.
//

class BaseResponse: Decodable {
    var status: String?
    var code: String?
    var message: String?
    
    enum CodingKeys: String, CodingKey {
        case status, code, message
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        status = try? container.decode(String.self, forKey: .status)
        code = try? container.decode(String.self, forKey: .code)
        message = try? container.decode(String.self, forKey: .message)
    }
}
