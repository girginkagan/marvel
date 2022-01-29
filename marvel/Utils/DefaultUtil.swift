//
//  DefaultUtil.swift
//  marvel
//
//  Created by Kagan Girgin on 1/29/22.
//

import Foundation

let ts = 1
let publicKey = "b60728e2044109a9342b9a40dc8832a3"
let privateKey = "411c5db478aed39988172680b84026d232bb78a3"

var hash: String {
    let combined = "\(ts)\(privateKey)\(publicKey)"
    let md5Data = MD5(string: combined)
    let md5Hex = md5Data.map { String(format: "%02hhx", $0) }.joined()

    return md5Hex
}

func MD5(string: String) -> Data {
    let messageData = string.data(using:.utf8)!
    var digestData = Data(count: Int(CC_MD5_DIGEST_LENGTH))

    _ = digestData.withUnsafeMutableBytes {digestBytes in
        messageData.withUnsafeBytes {messageBytes in
            CC_MD5(messageBytes, CC_LONG(messageData.count), digestBytes)
        }
    }

    return digestData
}
