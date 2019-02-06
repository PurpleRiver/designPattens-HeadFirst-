// Паттерн "Наблюдатель" определяет отношение один-ко-многим между объектами таким образом, что при изменении состояния однго объекта происходит автоматическое оповещение и обновление всех зависимых объектов.

protocol Subject {
    func registerObserver(_ observer: Observer)
    func removeObserver(_ observer: Observer)
    func notifyObservers()
}

// Интерфейс Observer реализуется всеми наблюдателями. Все должны реализовать метод update().
protocol Observer {
    func update(temperature: Float, humidity: Float, pressure: Float)
}

protocol DisplayElement {
    func display()
}

class WeatherData: Subject {
    private var observers: [Observer] = []
    private var temperature: Float = 0
    private var humidity: Float = 0
    private var pressure: Float = 0
    
    func registerObserver(_ observer: Observer) {
        observers.append(observer)
    }
    func removeObserver(_ observer: Observer) {
        observers.remove(at: observers.last as! Int)
    }
    func notifyObservers() {
        for observer in observers {
            observer.update(temperature: temperature, humidity: humidity, pressure: pressure)
        }
    }
    func measurmentsChanged() {
        notifyObservers()
    }
    
    // Setter
    func setMeasurments(temperature: Float, humidity: Float, pressure: Float) {
        self.temperature = temperature
        self.humidity = humidity
        self.pressure = pressure
        measurmentsChanged()
    }
}

class CurrentConditionsDisplay: Observer, DisplayElement {
    
    private var temperature: Float = 0
    private var humidity: Float = 0
    private let weatherData: Subject
    
    init(_ weatherData: WeatherData ) {
        self.weatherData = weatherData
        weatherData.registerObserver(self)
    }
    
    func update(temperature: Float, humidity: Float, pressure: Float) {
        self.temperature = temperature
        self.humidity = humidity
        display()
    }
    
    func display() {
        print("Current conditions: + \(temperature)C degrees and + \(humidity)% humidity")
    }
}

let weatherStation = WeatherData()
let currentDisplay = CurrentConditionsDisplay(weatherStation)
weatherStation.setMeasurments(temperature: 13, humidity: 79, pressure: 30)
weatherStation.setMeasurments(temperature: 15, humidity: 80, pressure: 29)
