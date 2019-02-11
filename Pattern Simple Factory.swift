// Класс инкапсулирующий подробности создания объектов. Простая фабрика скорее идиома программирования, чем паттрен.

// Продукт производимый фабрикой: пицца.
// Абстрактный класс с реализациями, которые могут пререопределяться в субклассах.
protocol Pizza {
    func prepare()
    func bake()
    func cut()
    func box()
}

class CheesePizza: Pizza {
    func prepare() { }
    func bake() { }
    func cut() { }
    func box() { }
}

class PepperoniPizza: Pizza {
    func prepare() { }
    func bake() { }
    func cut() { }
    func box() { }
}
//
//class GreekPizza: Pizza {
//    func prepare() { }
//    func bake() { }
//    func cut() { }
//    func box() { }
//}

// Удаляем греческую добавляем морскую пиццу.
class ClamPizza: Pizza {
    func prepare() { }
    func bake() { }
    func cut() { }
    func box() { }
}

class PizzaStore {
    // Классу PizzaStore передается ссылка на SimplePizzaFactory
    let factory: SimplePizzaFactory
    // PizzaStore сохраняет ссылку на фабрику в конструкторе
    init(factory: SimplePizzaFactory) {
        self.factory = factory
    }
    
    func orderPizza(type: String) -> Pizza {
        // Метод orderPizza() обращается к фабрике с запросом на создание объекта, передавая тип заказа.
        // Вместо создания нового экземпляра вызов метода create объекта фабрики.
        let pizza = factory.createPizza(type)
        
        // Получив объект pizza. Готовим, выпекаем, разрезаем и кладем в коробку.
        // Эти операции не меняются.
        pizza.prepare()
        pizza.bake()
        pizza.cut()
        pizza.box()
        
        return pizza
    }
}

// Фабрика должна быть единственной частью приложения, работающей с конкретными классами пиццы.
class SimplePizzaFactory {
    var pizza: Pizza! = nil
    
     func createPizza(_ type: String) -> Pizza {
        
        switch type {
        case "cheese":
            pizza = CheesePizza()
        case "pepperoni":
            pizza = PepperoniPizza()
            // Код не закрыт для изменений. Меню пиццерии может изменяться.
//        case "greek":
//            pizza = GreekPizza()
        case "clam":
            pizza = ClamPizza()
        default:
            print("Its not in a menu")
        }
        return pizza
    }
}

let pizzaStore = PizzaStore(factory: SimplePizzaFactory())
pizzaStore.orderPizza(type: "cheese")
