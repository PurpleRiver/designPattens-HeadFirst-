// Абстрактная фабрика предоставляет интерфейс создания семейств взаимосвязанных или взаимозаменяемых объектов без указания их конкретных классов. АБ основанна на композиции. Созднаие объектов реализуется в методе, доступ к которому осуществляется через интерфейс фабрики.
// В каждом городе пиццы делаются из одних компонентов, но в разных регионах используются разные реализации этих компонентов.
// Решение: создать фабрику для создания компонентов. Фабрика несет ответсвенность за создание каждого ингридиента.
protocol PizzaStore {
    func orderPizza(_ type: String) -> Pizza
    func makePizza(_ type: String) -> Pizza
}

extension PizzaStore {
    func orderPizza(_ type: String) -> Pizza {
        let pizza = makePizza(type)
        
        pizza.prepare()
        pizza.bake()
        pizza.cut()
        pizza.box()
        return pizza
    }
}

class NYPizzaStore: PizzaStore {
    func makePizza(_ type: String) -> Pizza {
        
        var pizza: Pizza! = nil
        // Фабрика производит ингриденты для всех пицц в NY стиле.
        let ingridientFactory = NYPizzaIngridientFactory()
        
        switch type {
        case "cheese":
            // При создании каждой пиццы задается фабрика, которая должна использоваться для производства ее ингридиентов.
            pizza = CheesePizza("NY Style Cheese Pizza", ingridientFactory)
//        case "pepperoni":
//            pizza = PepperoniPizza("NY Style Pepperoni Pizza", ingridientFactory)
//        case "clam":
//            pizza = ClamPizza("NY Style Clam Pizza", ingridientFactory)
        default:
            print("Its not in a menu")
        }
        return pizza
    }
}
// Интерфейс фабрики
protocol PizzaIngridientFactory {
    func makeDough() -> Dough
    func makeSause() -> Sause
    func makeCheese() -> Cheese
    func makeVeggies() -> [Veggies]
    func makePepperoni() -> Pepperoni
    func makeClam() -> Clams
}

protocol Dough: CustomStringConvertible { }
protocol Sause: CustomStringConvertible { }
protocol Cheese: CustomStringConvertible { }
protocol Veggies: CustomStringConvertible { }
protocol Pepperoni: CustomStringConvertible { }
protocol Clams: CustomStringConvertible { }

class Pizza {
    var name: String
    // Каждый объект пиццы содержит набор ингридиентов, используемых при ее приготовлении.
    var dough: Dough?
    var sause: Sause?
    var veggies: Veggies?
    var cheese: Cheese?
    var pepperoni: Pepperoni?
    var clams: Clams?
    
    init(_ name: String) {
        self.name = name
    }
    // Метод prepare стал абстрактным. В нем собираются ингридиенты, необходимые для приготовления.
    func prepare() {
        
    }
}

extension Pizza {
  
    func bake() {
        print("Bake for 25 minutes at 350")
    }
    func cut() {
        print("Cutting the pizza into diagonal slices")
    }
    func box() {
        print("Place pizza in official PizzaStore box")
    }
}

// Набор ингридиентов для, которые будут использоваться с фабрикой.
class ThinCrustDough: Dough {
    var description: String { return "Thin Crust Dough"}
}
class MarinaraSauce: Sause {
    var description: String { return "Marinara Sauce"}
}
class ReggianoCheese: Cheese {
    var description: String { return "Reggiano Cheese"}
}
class Onion: Veggies {
    var description: String { return "Onion"}
}
class RedPepper: Veggies {
    var description: String { return "RedPepper"}
}
class SlicedPepperoni: Pepperoni {
    var description: String { return "Sliced Pepperoni"}
}
class FreshClam: Clams {
    var description: String { return "Fresh Clams"}
}
// При написании кода фабричного метода были классы NYCheesePizza и ChicagoCheesePizza.
// Фабрика ингридиентов справится с региональными различиями.
class CheesePizza: Pizza {

    let ingridientFactory: PizzaIngridientFactory
    // Конструктору каждого класса пиццы передается объект фабрики, ссылка на который сохраняется в переменной экземпляра.
    init(_ name: String, _ ingridientFactory: PizzaIngridientFactory) {
        self.ingridientFactory = ingridientFactory
        super.init(name)
    }
    // Метод prepare готовит пиццу с сыром. Когда ему требуется очередной ингридиент, он запрашивает его у фабрики.
    override func prepare() {
        print("Preparing " + name)
        dough = ingridientFactory.makeDough()
        sause = ingridientFactory.makeSause()
        cheese = ingridientFactory.makeCheese()
    }
}
// Фабрика для NY региона.
class NYPizzaIngridientFactory: PizzaIngridientFactory {
    func makeDough() -> Dough {
        return ThinCrustDough()
    }
    func makeSause() -> Sause {
        return MarinaraSauce()
    }
    func makeCheese() -> Cheese {
        return ReggianoCheese()
    }
    func makeVeggies() -> [Veggies] {
        return [Onion(), RedPepper()]
    }
    func makePepperoni() -> Pepperoni {
        return SlicedPepperoni()
    }
    func makeClam() -> Clams {
        return FreshClam()
    }
}

let nyPizzaStore = NYPizzaStore()
nyPizzaStore.orderPizza("cheese")
