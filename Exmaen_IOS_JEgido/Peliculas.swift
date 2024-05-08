//
//  Peliculas.swift
//  Exmaen_IOS_JEgido
//
//  Created by Mañanas on 8/5/24.
//

import Foundation

struct PeliculasResponse : Codable {
    let Search: [Peliculas]
}

struct Peliculas : Codable {
    let Title: String
    let Poster: String
    let Year: String
    let Plot:String?
    let imdbID:String
    let Genre:String?
    let Director:String?
    let Language:String?
    let Country:String?
  
}

struct Image: Codable {
    let url: String
}




func getPeliculasAPI(name: String) async throws -> [Peliculas] {
    guard let url = URL(string: "http://www.omdbapi.com/?apikey=550589a5&s=\(name)") else {
        throw RuntimeError("URL inválida")
    }

    do {
        let (data, _) = try await URLSession.shared.data(from: url)
        let decodedJson = try JSONDecoder().decode(PeliculasResponse.self, from: data)
        return decodedJson.Search
    } catch {
        throw error
    }
}


func getPeliculasAPIDescrip(name: String) async throws -> Peliculas {
    guard let url = URL(string: "http://www.omdbapi.com/?apikey=550589a5&i=\(name)") else {
        throw RuntimeError("URL inválida")
    }

    do {
        let (data, _) = try await URLSession.shared.data(from: url)
        let decodedJson = try JSONDecoder().decode(Peliculas.self, from: data)
        return decodedJson
    } catch {
        throw error
    }
}


struct RuntimeError: Error {
    let description: String
    
    init(_ description: String) {
        self.description = description
    }
}
