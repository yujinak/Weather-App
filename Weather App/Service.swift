//
//  Service.swift
//  Weather App
//
//  Created by Gabriel Yuji Nakashima on 30/07/24.
//

import Foundation


struct City {
    let lat: String
    let lon: String
    let name: String
}

class Service {
    private let apiKey: String = "985dc8597562bdb1392c1e5fbb0c632e"
    private let session = URLSession.shared
    
    private let currentWeatherBaseURL: String = "https://api.openweathermap.org/data/2.5/weather"
    private let forecastBaseURL:String = "https://api.openweathermap.org/data/2.5/forecast"
    
    func fetchForecastData(city: City, _ completion: @escaping (ForecastResponse?) -> Void){
        let forecastUrlString = "\(forecastBaseURL)?lat=\(city.lat)&lon=\(city.lon)&appid=\(apiKey)"
        guard let url = URL(string: forecastUrlString) else { return }
        
    
        let taskForescastUrlString = session.dataTask(with: url) { data, response, error in
            
            guard let data = data else {
                completion(nil)
                return
            }
            do {
                let forecastResponse = try JSONDecoder().decode(ForecastResponse.self, from: data)
                completion(forecastResponse)
            } catch {
                print(error)
                completion(nil)
            }
        }
        taskForescastUrlString.resume()
    }
    
    func fetchCurrentWeatherData(city: City, _ completion: @escaping (CurrentWeatherResponse?) -> Void){
        let currentWeatherUrlString = "\(currentWeatherBaseURL)?lat=\(city.lat)&lon=\(city.lon)&appid=\(apiKey)"
        guard let url = URL(string: currentWeatherUrlString) else { return }
        
    
        let taskCurrentWeatherUrlString = session.dataTask(with: url) { data, response, error in
            
            guard let data = data else {
                completion(nil)
                return
            }
            do {
                let currentWeatherResponse = try JSONDecoder().decode(CurrentWeatherResponse.self, from: data)
                completion(currentWeatherResponse)
            } catch {
                print(error)
                completion(nil)
            }
        }
        taskCurrentWeatherUrlString.resume()
    }
}



// --------- Tipos dos Dados de Previsão do Tempo a cada 3 horas  ---------------- //

// MARK: - ForecastResponse
struct ForecastResponse: Codable {
    let cod: String
    let message, cnt: Int
    let list: [List]
    let city: CityData
}

// MARK: - City
struct CityData: Codable {
    let id: Int
    let name: String
    let coord: Coord
    let country: String
    let population, timezone, sunrise, sunset: Int
}

// MARK: - List
struct List: Codable {
        let dt: Int
        let main: MainClass
        let weather: [forecastWeather]
        let wind: Wind
        let dtTxt: String
        
        enum CodingKeys: String, CodingKey {
            case dtTxt = "dt_txt"
            case dt
            case main
            case weather
            case wind
        }
    
//    init(from decoder: Decoder) throws {
//            let values = try decoder.container(keyedBy: CodingKeys.self)
//            dt = try values.decode(Int.self, forKey: .dt)
//            main = try values.decode(MainClass.self, forKey: .main)
//            weather = try values.decode([Weather].self, forKey: .weather)
//            forecastWind = try values.decode(Wind.self, forKey: .forecastWind)
//            dtTxt = try values.decode(String.self, forKey: .dtTxt)
//
////            enum CodingKeys: String, CodingKey {
////                case dtTxt = "dt_txt"
////                case dt
////                case main
////                case weather
////                case forecastWind
////            }
//    }
}

// MARK: - MainClass
struct MainClass: Codable {
    let temp, tempMin, tempMax: Double
    let humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case humidity
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

// MARK: - Weather
struct forecastWeather: Codable {
    let id: Int
    let main: MainEnum
    let description: Description
//    let icon: Icon
}

enum Description: String, Codable {
    case clearSky = "clear sky"
}

enum MainEnum: String, Codable {
    case clear = "Clear"
}

// ---------- Tipos dos Dados do Tempo Atual ---------------------------

// MARK: - Current
struct CurrentWeatherResponse: Codable {
    let coord: Coord
    let currentWeather: [CurrentWeather]
    let base: String
    let main: Main
    let visibility: Int
    let currentWind: Wind
    let dt: Int
    let currentSys: currentSys
    let timezone, id: Int
    let name: String
    let cod: Int
}

// MARK: - Coord
struct Coord: Codable {
    let lon, lat: Double
}

// MARK: - Main
struct Main: Codable {
    let temp, tempMin, tempMax: Double
    let humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case humidity
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

// MARK: - Sys
struct currentSys: Codable {
    let type, id: Int
    let country: String
}

// MARK: - Weather
struct CurrentWeather: Codable {
    let id: Int
    let main, description, icon: String
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double
}
