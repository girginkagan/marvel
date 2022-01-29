//
//  RestClient.swift
//  marvel
//
//  Created by Kagan Girgin on 1/28/22.
//

import Alamofire

public class RestClient: IServiceHandler {
    static let sharedInstance = RestClient()
    
    private func sendRequest<T: Codable>(_ request: BaseRequest, _ type: T.Type, successCompletion: @escaping(T) -> (), errorCompletion:  @escaping(BaseModelError) -> ()) {
        AF.request(request.request()).responseDecodable { (response: AFDataResponse<T>) in
            switch response.result {
                case .success(let json):
                if response.response!.statusCode == APIStatusCodes.Success.rawValue {
                    successCompletion(json)
                }
                else {
                    print(response.result)
                    errorCompletion(BaseModelError(errorCode: response.response!.statusCode, message: "An unknown error occured.", errors: nil))
                }
                case .failure(let error):
                    errorCompletion(BaseModelError(errorCode: nil, message: nil, errors: [ErrorData(field: APIErrors.Alamofire.rawValue, message: error.localizedDescription)]))
                    print(error.localizedDescription)
            }
        }
    }
    
    func getCharacters(offset: Int, successCompletion: @escaping (CharactersResponseModel) -> (), errorCompletion: @escaping (BaseModelError) -> ()) {
        let request = GetCharactersApiRequest(offset: offset)
        sendRequest(request, CharactersResponseModel.self, successCompletion: successCompletion, errorCompletion: errorCompletion)
    }
    
    func getComicsByCharacter(characterId: Int, successCompletion: @escaping (ComicsResponseModel) -> (), errorCompletion: @escaping (BaseModelError) -> ()) {
        let request = GetComicsByCharacterApiRequest(characterId: characterId)
        sendRequest(request, ComicsResponseModel.self, successCompletion: successCompletion, errorCompletion: errorCompletion)
    }
}
