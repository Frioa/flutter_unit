# 设计模式(Dart版)

## 三类设计模式

|分类|特点|例子|
| ------   | -----  | ---- |
|[Creational Design Pattern](#种类一-Creational-Design-Pattern)|注重如何初始化一个或一群实体。|Factory, Builder, Prototype, Singleton, ...|
|[Structural Design Pattern](#种类二-Structural-Design-Pattern)|注重实体之间互相「组合」取代「继承」。|Decorator, Adapter, Composite, Facade, Proxy, ...|
|[Behavioral Design Pattern](#种类三-Behavioral-Design-Pattern)|注重分配每个实体的功能，建立联系沟通。|Strategy, Observer, State, Command, Iterator, Template, ...|


## 六大设计原则

### SOLID 原则

* 单一职责原则 (Single responsibility principle, SRP)

  每个实体，不管是 class 还是 function，其功能都应该专注于一件事上。

  同时做两件以上的事情，不但阅读性降低，出错时也更难找到问题点。

  另外多个职责耦合在一起，会影响复用性。



* 开放封闭原则 (Open-Close principle, OCP)

  > 通过**增加新代码**来扩展系统的功能，而不是通过**修改原本已经存在的代码**来扩展系统的功能。

  当未来需求有异动时，在不变动现在正常运行的代码之下，通过其他方式新增代码，实现新需求。

  如果为了新需求而改动原有代码，可能会造成其他调用原本代码时发生非预期错误。

  *注：为了使程序的扩展性好，易于维护和升级，我们需要使用接口和抽象类。*




* 里氏替换原则 (Liskov substitution principle, LSP)

  任何基类可以出现的地方，子类一定可以出现（替换）。

  需满足：子类可以扩展父类的功能，但不能改变父类原有的功能。

  只有当衍生类可以替换掉基类，软件单位的功能不受到影响时，基类才能真正被复用，而衍生类也能够在基类的基础上增加新的行为。

  *注：实现 OCP 原则的关键步骤就是抽象化，而基类与子类的继承关系是抽象化的具体实现，所以里氏代换原则是对实现抽象化的具体步骤的规范。*





* 接口隔离原则 (Interface segregation principle, ISP)

  使用多个隔离的小接口，比使用单个整合在一起的大接口要好。

  为了方便维护和升级已有的代码，需要尽量降低类之间的耦合度，降低依赖，降低耦合。




* 依赖反转原则 (Dependency inversion principle, DIP)

  要依赖于抽象，而不依赖于具体。

  即高低阶层代码都依赖一个抽象类，在抽象类中定义所依赖的方法，并由子类去实现。



* 最少知识原则（Least knowledge principle, LKP）

  > Talk only to your immediate friends

  实体之间的联系（通信/交流）应当尽量少。

  即一个实体应当尽量少的与其他实体之间发生相互作用，使得系统功能模块相对独立。

  这样当一个模块修改时，就会尽量少的影响其他的模块，扩展会相对容易（主要还是解耦思想）。




### DRY 原则

> Do not repeat yourself

系统的每一个功能都应该有唯一的实现。

也就是说，如果多次遇到同样的问题，就应该抽象出一个共同的解决方法，不要重复开发同样的功能。

也指在软件开发中，减少重复的代码（包括注释，无意或隐藏的重复代码片段），降低耦合，方便后期扩展维护。



### KISS 原则

> Keep it simple and stupid

大道至简，简单逻辑处理好了，系统才会稳固。



### YAGNI 原则

> You Ain't Gonna Need It

是指你自以为有用的功能，实际上都是用不到的（极限编程思想）。

要尽可能快、尽可能简单地让软件运行起来（do the simplest thing that could possibly work）

另外在设计层面上，也包含“不要为了设计而设计”的思想，大道至简，如无必要，勿增实体（禅）。




### ROT 原则

> Rule of three

是指某个功能出现第三次时才进行"抽象化"。

这样的好处是：

* **省事**。如果一种功能只在一两个地方用到，就不需要在抽象上耗费时间。

* **容易发现模式**。"抽象化"需要找到问题的模式，问题出现的场合越多，就越容易看出模式，从而可以更准确地抽象。



### CRP 原则

> Composite Reuse Principle

要尽量使用组合/聚合关系，少用继承。

通过关联关系（组合/聚合）来使用一些已有对象，并使之成为新对象的一部分。

然后通过新对象委派调用已有对象的方法，以达到复用其已有功能的目的。


