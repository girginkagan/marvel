//
//  GetCharactersApiRequest.swift
//  marvel
//
//  Created by Kagan Girgin on 1/28/22.
//

import Foundation

public class GetCharactersApiRequest: BaseRequest {
    public var requestBodyObject: BaseObject?
    public var requestMethod = RequestHttpMethod.Get
    public var requestPath: String = "characters"
    
    init(offset: Int) {
        requestPath += "?limit=30&offset=\(offset)&apikey=\(publicKey)&hash=\(hash)&ts=\(ts)"
    }
}
