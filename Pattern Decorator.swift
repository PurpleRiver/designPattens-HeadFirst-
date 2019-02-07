// Паттерн Декоратор динамически наделяет объект новыми возможностями и является
// гибкой альтернативой субклассированию в области расширения функциональности.

protocol Beverage {
    var description: String { get }
    
    func cost() -> Double
}

// Конкретные реализации базовых напитков
class Espresso: Beverage {
    var description: String = "Espresso"
    
    func cost() -> Double {
        return 1.99
    }
}

class HouseBlend: Beverage {
    var description: String = "House Blend Coffe"
    
    func cost() -> Double {
        return 0.89
    }
}

// Абстрактный класс для дополнений
protocol CondimentDecorator: Beverage {
  
}

// Реализации дополнений через Декоратор (CondimentDecorator)
class Mocha: CondimentDecorator {
   // Переменная для хранения ссылки
    private let beverage: Beverage
    var description: String {
           return beverage.description + ", Mocha"
    }
    
    // Способ присваивания переменной ссылки на объект. Передает ссылку при вызове конструктора.
    init(_ beverage: Beverage) {
        self.beverage = beverage
    }
    
    func cost() -> Double {
        return 0.20 + beverage.cost()
    }
}

class Whip: CondimentDecorator {
    private let beverage: Beverage
    var description: String {
        return beverage.description + ", Whip"
    }
    
    init(_ beverage: Beverage) {
        self.beverage = beverage
    }
    
    func cost() -> Double {
        return 0.10 + beverage.cost()
    }
}

class Soy: CondimentDecorator {
    private let beverage: Beverage
    var description: String {
        return beverage.description + ", Soy"
    }
    
    init(_ beverage: Beverage) {
        self.beverage = beverage
    }
    
    func cost() -> Double {
        return 0.20 + beverage.cost()
    }
}
// Just Espresso
var beverage: Beverage = Espresso()
print("\(beverage.description) \(beverage.cost())$ ")
// Espresso with 2xMocha + Whip
beverage = Mocha(beverage)
beverage = Mocha(beverage)
beverage = Whip(beverage)
print(beverage.description)
