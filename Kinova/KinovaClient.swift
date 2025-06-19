//
//  KinovaClient.swift
//  Kinova
//
//  Created by Igor Camilo on 19.06.25.
//  Copyright © 2025 Igor Camilo. All rights reserved.
//

import Foundation
import Observation

@Observable
final class KinovaClient {
    private let decoder: JSONDecoder

    init() {
        self.decoder = JSONDecoder()
        self.decoder.keyDecodingStrategy = .convertFromSnakeCase
    }

    private func list<T: Decodable>(endpoint: String) async throws -> [T] {
        let apiKey = Secrets.tmdbAPIKey
        let urlString = "https://api.themoviedb.org/3/\(endpoint)?api_key=\(apiKey)"
        guard let url = URL(string: urlString) else {
            throw KinovaClientError.invalidURL(urlString)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try decoder.decode(TMDBResponse<T>.self, from: data)
        return response.results
    }

    func popularMovies() async throws -> [Movie] {
        let movies: [TMDBMovie] = try await list(endpoint: "movie/popular")
        return try movies.map { try $0.formatted() }
    }

    func nowPlayingMovies() async throws -> [Movie] {
        let movies: [TMDBMovie] = try await list(endpoint: "movie/now_playing")
        return try movies.map { try $0.formatted() }
    }

    func upcomingMovies() async throws -> [Movie] {
        let movies: [TMDBMovie] = try await list(endpoint: "movie/upcoming")
        return try movies.map { try $0.formatted() }
    }

    func topRatedMovies() async throws -> [Movie] {
        let movies: [TMDBMovie] = try await list(endpoint: "movie/top_rated")
        return try movies.map { try $0.formatted() }
    }

    func popularTVShows() async throws -> [TVShow] {
        let tvShows: [TMDBTVShow] = try await list(endpoint: "tv/popular")
        return try tvShows.map { try $0.formatted() }
    }

    func airingTodayTVShows() async throws -> [TVShow] {
        let tvShows: [TMDBTVShow] = try await list(endpoint: "tv/airing_today")
        return try tvShows.map { try $0.formatted() }
    }

    func onTheAirTVShows() async throws -> [TVShow] {
        let tvShows: [TMDBTVShow] = try await list(endpoint: "tv/on_the_air")
        return try tvShows.map { try $0.formatted() }
    }

    func topRatedTVShows() async throws -> [TVShow] {
        let tvShows: [TMDBTVShow] = try await list(endpoint: "tv/top_rated")
        return try tvShows.map { try $0.formatted() }
    }
}

enum KinovaClientError: Error {
    case invalidURL(String)
}

struct TMDBResponse<T: Decodable>: Decodable {
    var results: [T]
}

private struct TMDBMovie: Codable {
    var id: Int
    var posterPath: String
    var title: String

    func formatted() throws -> Movie {
        let posterURLString = "https://image.tmdb.org/t/p/w500\(posterPath)"
        guard let posterURL = URL(string: posterURLString) else {
            throw KinovaClientError.invalidURL(posterURLString)
        }
        return Movie(id: id, posterURL: posterURL, title: title)
    }
}

private struct TMDBTVShow: Codable, Identifiable {
    var id: Int
    var name: String
    var posterPath: String

    func formatted() throws -> TVShow {
        let posterURLString = "https://image.tmdb.org/t/p/w500\(posterPath)"
        guard let posterURL = URL(string: posterURLString) else {
            throw KinovaClientError.invalidURL(posterURLString)
        }
        return TVShow(id: id, posterURL: posterURL, title: name)
    }
}

struct Movie: Hashable, Identifiable, PosterProvider {
    var id: Int
    var posterURL: URL
    var title: String
}

struct TVShow: Hashable, Identifiable, PosterProvider {
    var id: Int
    var posterURL: URL
    var title: String
}

protocol PosterProvider: Identifiable {
    var posterURL: URL { get }
    var title: String { get }
}
