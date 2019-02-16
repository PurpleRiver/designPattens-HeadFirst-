// Паттерн одиночка гарантирует, что класс имеет только один экземпляр, и представляет глобальную точку доступа к этому экземпляру.
class ChocolateBoiler {
    private var isEmpty: Bool
    private var isBoiled: Bool
    // Переменная класса instance содержит один и только один экземпляр ChocolateBoiler
    // Константа уже потокобезопасна, значение в нее может быть записано только один раз и это сделает тот поток, который доберется до нее первым
    private static let uniqueInstance = ChocolateBoiler()
    
    private init() {
        isEmpty = true
        isBoiled = false
    }
    
    static func getInstance() -> ChocolateBoiler {
        return uniqueInstance
    }
}
let chocolateBoiler = ChocolateBoiler.getInstance()
