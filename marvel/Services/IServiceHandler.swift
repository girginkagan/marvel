//
//  IServiceHandler.swift
//  marvel
//
//  Created by Kagan Girgin on 1/28/22.
//

import Foundation

protocol IServiceHandler {
    func getCharacters(offset: Int, successCompletion: @escaping(CharactersResponseModel) -> (), errorCompletion: @escaping(BaseModelError) -> ())
    func getComicsByCharacter(characterId: Int, successCompletion: @escaping(ComicsResponseModel) -> (), errorCompletion: @escaping(BaseModelError) -> ())
}
