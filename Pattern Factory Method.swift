// Фабричный метод - инкапсулирует создание объектов. Позволяя субклассам решить какой объект создать.
// Делаем франшизу для нашей пиццерии. Для этого нужно создать фабрики в разных стилях.
// Нужно локализовать все операции по изготовлению пиццы в классе PizzaStore, но сохранить для
// пиццерий достаточную гибкость для выбора регионального стиля.
protocol Pizza {
    func prepare()
    func bake()
    func cut()
    func box()
}
// PizzaStore стал абстрактным
// Класс создатель содер. код, зависящий от абстр. продукта производимого субклассом. Создатель не знает кокой конкретный продукт
// будет произведен.
protocol PizzaStore {
    
    func orderPizza(_ type: String) -> Pizza
    // Метод makePizza принадлежит PizzaStore, а не классу фабрики.
    // Фабричный метод стал абстракным методом PizzaStore
    func makePizza(_ type: String) -> Pizza
}

extension PizzaStore {
    // Нам нужно чтобы у метода orderPizza была реализация, а makePizza реализовывался в субклассах
    // В Свифте это можно сделать через extension
    func orderPizza(_ type: String) -> Pizza {
        let pizza = makePizza(type)
        
        pizza.prepare()
        pizza.bake()
        pizza.cut()
        pizza.box()
        
        return pizza
    }
}

// Создадим субкласс для каждой региональной разновидности пиццериии
// Классы создающие продукты(Pizza), называют конкретными создателями.
class NYPizzaStore: PizzaStore {
    // Необходимо реализовать метод makePizza т.к. он PizzaStore объявлен абстрактным.
    func makePizza(_ type: String) -> Pizza {
        var pizza: Pizza! = nil
        
        switch type {
        case "cheese":
            pizza = NYStyleCheesePizza()
            //        case "pepperoni":
            //            pizza = NYStylePepperoniPizza()
            //        case "clam":
            //            pizza = NYStyleClamPizza()
        default:
            print("Its not in a menu")
        }
        return pizza
    }
}
// Конкретные продукты
class NYStyleCheesePizza: Pizza {
    func prepare() { }
    func bake() { }
    func cut() { }
    func box() { }
}

class ChicagoPizzaStore: PizzaStore {
    
    func makePizza(_ type: String) -> Pizza {
        var pizza: Pizza! = nil
        
        switch type {
        case "cheese":
            pizza = ChicagoStyleCheesePizza()
            //        case "pepperoni":
            //            pizza = ChicagoStylePepperoniPizza()
            //        case "clam":
            //            pizza = ChicagoStyleClamPizza()
        default:
            print("Its not in a menu")
        }
        return pizza
    }
}

class ChicagoStyleCheesePizza: Pizza {
    func prepare() { }
    func bake() { }
    func cut() { }
    func box() { }
}

let nyPizzaStore = NYPizzaStore()
// Метод orderPizza() суперкласса понятия не имеет, какой из типов пиццы мы создаем.
nyPizzaStore.orderPizza("cheese")

let chicagoPizzaStore = ChicagoPizzaStore()
chicagoPizzaStore.orderPizza("cheese")

