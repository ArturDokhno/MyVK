import UIKit

 protocol Coffee {
     var cost: Double { get }
 }

 class SimpleCoffee: Coffee {
     var cost: Double {
         return 100
     }
 }

 protocol DecoratorCoffee: Coffee {
     var baseCoffee: Coffee { get }
     init(base: Coffee)
 }

 class CoffeeWithMilk: DecoratorCoffee {
     var baseCoffee: Coffee

     required init(base: Coffee) {
         self.baseCoffee = base
     }

     var cost: Double {
         return self.cost + 50
     }
 }

 class CoffeeWithSugar: DecoratorCoffee {
     var baseCoffee: Coffee

     required init(base: Coffee) {
         self.baseCoffee = base
     }

     var cost: Double {
         return self.cost + 20
     }
 }

 class CoffeeWithWhip: DecoratorCoffee {
     var baseCoffee: Coffee

     required init(base: Coffee) {
         self.baseCoffee = base
     }

     var cost: Double {
         return self.cost + 100
     }
 }

var coffee = CoffeeWithCream(base:CoffeeWithMilk(base: CoffeeWithSugar(base: ClassicCoffee())))
 print(coffee.cost)
