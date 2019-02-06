
// Паттерн "Стратегия" определяет семейство алгоритмов, инкапсулирует каждый из них и обеспечивает их взаимозаменяемость.
// Он позволяет модифицировать алгоритмы независимо от их использования на стороне клиента.
// Применение: Для реализации разных вариантов поведения. Поведение инкапсулируется(т.к изменяется) в отдельном наборе классов.

protocol Flyable {
   func fly()
}

class FlyWithWings: Flyable {
    func fly() {
        print("I can fly!")
    }
}

class FlyNoWay: Flyable {
    func fly() {
        print("Can't fly(")
    }
}

class FlyRocketPowered: Flyable {
    func fly() {
        print("I'm flying like a rocket!")
    }
}

// Duck содержит интерфейс Quackable
protocol Quackable {
    func quack()
}
// Quack, Squeak, MuteQuack конкретные реализации поведения
class Quack: Quackable {
    func quack() {
        print("Quack, Quack")
    }
}

class Squeak: Quackable {
    func quack() {
        print("Squeak like a rubber duck")
    }
}

class MuteQuack: Quackable {
    func quack() {
        print("... ")
    }
}
// Duck абстрактный суперкласс
class Duck {
    // Каждый объект содержит ссылку на реализацию интерфейса Quackable.
    var flyBehavior: Flyable // Ссылочные переменные с типами интрефейсов поведения. Наследуются всеми субклассами.
    var quackBehavior: Quackable
    
    init(flyBehavior: Flyable, quackBehavior: Quackable) {
        self.flyBehavior = flyBehavior
        self.quackBehavior = quackBehavior
    }
    
    func performFly() {
        flyBehavior.fly()
    }
     // Объект делегирует поведение объекту, на который ссылается quackBehavior
    func performQuack() {
        quackBehavior.quack()
    }
    // Классам Duck не нужно знать подробности реализации своих аспектов поведения. Такая архитектура позволяет использовать
    // поведение fly() & quack() в других типах объектов( Поведение не скрывается в классах Duck )
    // Можно добавлять новые аспекты поведения без изменения существующих классов
}

// Класс наследует переменные flyBehavior и quackBehavior от класса Duck
// MallardDuck является конкретной реализацией Duck("расширяет" класс)
class MallardDuck: Duck {
    init() {
        // MallardDuck использует класс Quack() для выполнения действия performQuack()
       super.init(flyBehavior: FlyWithWings(), quackBehavior: Quack())
    }
  // Хотя аспекты поведения связываются с конкретными реализациями, их можно легко менять динамически
}

let mallardDuck = MallardDuck()
mallardDuck.performFly()
mallardDuck.performQuack()

class RubberDuck: Duck {
    init() {
        super.init(flyBehavior: FlyNoWay(), quackBehavior: Squeak())
    }
}

let rubberDuck = RubberDuck()
rubberDuck.performFly()
rubberDuck.performQuack()
// Изменение поведения на лету)
rubberDuck.flyBehavior = FlyRocketPowered() // Если бы реализация поведения находилась в иерархии Duck, такое было бы невозможно.
rubberDuck.performFly()
