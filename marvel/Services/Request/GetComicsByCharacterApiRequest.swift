//
//  GetComicsByCharacterApiRequest.swift
//  marvel
//
//  Created by Kagan Girgin on 1/29/22.
//

import Foundation

public class GetComicsByCharacterApiRequest: BaseRequest {
    public var requestBodyObject: BaseObject?
    public var requestMethod = RequestHttpMethod.Get
    public var requestPath: String = "characters"
    
    init(characterId: Int) {
        requestPath += "/\(characterId)/comics?dateRange=2005-01-01,\(Date().getFormattedDate())&orderBy=onsaleDate&limit=10&apikey=\(publicKey)&hash=\(hash)&ts=\(ts)"
    }
}
