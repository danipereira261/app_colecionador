import Foundation

class GameIntegration {


    let baseURL = "http://localhost:8080/games"

    func save(request: GameRequest, completion: @escaping (Error?) -> Void) {
        guard let url = URL(string: baseURL) else {
            completion(NetworkError.invalidURL)
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        do {
            urlRequest.httpBody = try JSONEncoder().encode(request)
        } catch {
            completion(error)
            return
        }
        let task = URLSession.shared.dataTask(with: urlRequest) { (_, response, error) in
            if let error = error {
                completion(error)
                return
            }
            if let httpResponse = response as? HTTPURLResponse,
               httpResponse.statusCode != 200 {
                completion(NetworkError.statusCode(httpResponse.statusCode))
                return
            }
            completion(nil)
        }
        task.resume()
    }

    func findAll(completion: @escaping (Result<[GameResponse], Error>) -> Void) {
        guard let url = URL(string: baseURL) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            if let httpResponse = response as? HTTPURLResponse,
               httpResponse.statusCode != 200 {
                completion(.failure(NetworkError.statusCode(httpResponse.statusCode)))
                return
            }
            guard let data = data else {
                completion(.success([]))
                return
            }
            do {
                let gameResponses = try JSONDecoder().decode([GameResponse].self, from: data)
                completion(.success(gameResponses))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }

    func findById(id: Int, completion: @escaping (Result<GameResponse, Error>) -> Void) {
        let urlString = "\(baseURL)/\(id)"
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            if let httpResponse = response as? HTTPURLResponse,
               httpResponse.statusCode != 200 {
                completion(.failure(NetworkError.statusCode(httpResponse.statusCode)))
                return
            }
            guard let data = data else {
                completion(.failure(NetworkError.emptyResponse))
                return
            }
            do {
                let gameResponse = try JSONDecoder().decode(GameResponse.self, from: data)
                completion(.success(gameResponse))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }

    func deleteById(id: Int, completion: @escaping (Error?) -> Void) {
        let urlString = "\(baseURL)/\(id)"
        guard let url = URL(string: urlString) else {
            completion(NetworkError.invalidURL)
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "DELETE"
        let task = URLSession.shared.dataTask(with: urlRequest) { (_, response, error) in
            if let error = error {
                completion(error)
                return
            }
            if let httpResponse = response as? HTTPURLResponse,
               httpResponse.statusCode != 200 {
                completion(NetworkError.statusCode(httpResponse.statusCode))
                return
            }
            completion(nil)
        }
        task.resume()
    }
}