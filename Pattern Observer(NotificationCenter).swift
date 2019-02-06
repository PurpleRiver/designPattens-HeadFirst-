/*
 Swift's Foundation framework provides several kinds of Observer patterns, including:
 - **Property willSet/didSet**, for observing changes to individual properties within an object (usually from a subclass)
 - **Property Key-Value Observing**, for observing changes to individual properties from another object
 - **Notifications**, for observing arbitrary changes, scoped to a single class or to any object in the application
 - **Cross-process Notifications**, similar to Notifications, but for observing changes between processes
 */

import Foundation

class WeatherData {
    private var temperature: Double = 0
    private var humidity: Double = 0
    private var pressure: Double = 0
    
    static var measurmentsChange = Notification.Name("measurmentsChange")
    
    func setMeasurements(temperature: Double, humidity: Double, pressure: Double) {
        self.temperature = temperature
        self.humidity = humidity
        self.pressure = pressure
        
        NotificationCenter.default.post(name: WeatherData.measurmentsChange, object: self)
    }
    // Getters to keep vars private
    func getTemperature() -> Double {
        return temperature
    }
    func getHumidity() -> Double {
        return humidity
    }
}

protocol DisplayElement {
    func display()
}

class CurrentConditionsDisplay: DisplayElement {
    private var temperature: Double = 0
    private var humidity: Double = 0
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(update), name: WeatherData.measurmentsChange, object: nil)
    }
    
    @objc func update(_ notification: Notification) {
        if let weatherData = notification.object as? WeatherData {
            self.temperature = weatherData.getTemperature()
            self.humidity = weatherData.getHumidity()
            display()
        }
    }
    
    func display() {
        print("Current conditions: + \(temperature)C degrees and + \(humidity)% humidity")
    }
}

let weatherStation = WeatherData()
// init and add observer
let currentWeather = CurrentConditionsDisplay()
weatherStation.setMeasurements(temperature: 23, humidity: 80, pressure: 30)
// Remove observer
NotificationCenter.default.removeObserver(currentWeather)
weatherStation.setMeasurements(temperature: 13, humidity: 78, pressure: 29)
