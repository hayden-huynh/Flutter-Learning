## Difference between Stateless and Stateful widgets:

- Stateless widgets:
  - Can get **external** input data through the class constructor(s) ***BUT*** cannot have internal *mutable* data
  - Only get re-rendered (build() function called again) when the **external input data changes**. Internal data changes have no effects so they should never change i.e. be *final*

- Stateful widgets:
  - Can get **external** input data through the class constructor(s) ***AND*** can have internal *mutable* data
  - Get re-rendered (build() function called again) whenever ***either external input data or internal data changes***

## State Lifting

- If two or more (custom) widgets relate to each other in terms of the state (data/variables) they affect, this state should be lifted up and handled in their common ancestor widget.

- If it is not desirable to have the common ancestor widget to be stateful (because it holds widgets that never changes thus should not be re-built every time), just create a new stateful widget solely for the purpose of combine children widgets together for state managing.

## Difference between `final` and `const`

- `final`: constant in runtime, not in compilation time
- `const`: constant in both compilation time (defined and initialized immediately) and runtime

## `const` pointers vs pointers to `const` data

- If the type is `Object`, the variable/constant name is actually the name of the pointer holding the address in memory to that object.
- If the pointer is `const`, it cannot be re-assigned to hold a different address. Example:
  ```dart
  const arr = [1, 2, 3];
  ```
- However, if the pointer is not `const` whereas the data is `const`, the pointer can be re-assigned but as long as it still holds the address to the `const` data, the data cannot be modified. Example:
  ```dart
  var arr = const [1, 2, 3];
  arr.add(4) // Not allowed
  arr = []; // Allowed
  ```

## SingleChildScrollView widget

- The `SingleChildScrollView` widget allows its child to be scrollable vertically as long as the child has a fixed height.

- Best practice: Wrap whatever you want to be scrollable with `Container` and have this `Container` as the child of the `SingleChildScrollView` widget.

## ListView widget

- The `ListView` widget has an infinite height, thus it needs to be wrapped with a `Container` clearly specifying the height or it will go out of the device screen.

- Different ways to use `ListView`:
  - `ListView(children: [])`: All children are rendered even if they are out of the device screen
  - `ListView.builder()`: List items are only rendered when they are scrolled to. When they are quite far out of the screen, they will be erased for memory optimization.
  - Should use `ListView.builder()` when not know how many list items there are.

## TextField input vs Flutter's automatic re-evaluation issue

- Occasionally, Flutter "re-evaluates" all widgets. This action may cause textfields in stateless widgets to lose their inputs.
- Solution: Convert the stateless widget into a stateful one.

## The `widget` and `context` keywords

- `widget`:
  - In stateful widgets, properties and methods should be defined in the widget class and not in the state class.
  - For the state class to access these properties and methods, we use the `widget` keyword as if it is an instance of the widget class and access those via the dot operator.
- `context`:
  - Same as `widget`, this keyword is especially offered in the state class of a stateful widget so that this class can access the context of the widget.

## MediaQuery + LayoutBuilder

- Use `MediaQuery` to access device's sizes and assign **dynamic** sizes for top-most/larger widgets in the widget tree.
- Use `LayoutBuilder` to size lower/smaller widgets in the widget tree relative to the sizes of those upper/larger widgets by accessing the constraints.

## Provider package/pattern

- Steps to properly use the Provider package:
  1. Create a custom class to hold all data and related logics (most common use case) that will later provide this data to other widgets and implement the `ChangeNotifier` mixin. Make a call to `notifyListeners()` function whenever listening widgets need re-building after some changes.
  2. Specify the top-most common ancestor widget of all interested widgets -> Wrap it with `ChangeNotifierProvider` -> Implement the `create` property with `(ctx) => <Instance of Provider class>`
  3. In the class of the listening widget, extract the data from the provider by `Provider.of<Provider type>(context).<data>` (must specify `Provider type` to target the correct provider)

- The data must be provided in the top-most common ancestor widget of all the widgets that are interested in listening to the changes in the provided data.

- Instead of using the Provider package with custom class type (like done in section 8 of the course), Provider can also be used with built-in types.
  - Example: 
  ```dart
    Provider<String>(builder: (ctx) => 'Hi, I am a text!', child: //...);
  ```
  - This use case is typically useful when you want to create a global ***constant*** variable that are accessible in many places without passing it through constructors.

- Alternative listening approach: wrap the listening widget with `Consumer` and implement the '`builder`' argument. 
  - Advantage of `Consumer` is that we can wrap smaller widget to rebuild exactly what needs to be and not everything around.

- Use `Multiprovider` and put all `ChangeNotifierProvider` into the '`providers`' list when a widget should have multiple providers.


## mixin and the `with` keyword

- Example of a `mixin`:
  ```dart
    mixin Agility {
      var speed = 10;

      void sitDown() {
        print('Sititng down...');
      }
    }

    class Person with Agility {
      String name;
      String age;

      Person(this.name, this.age);
    }

    void main() {
      final pers = Person('Max', 30);

      print(pers.speed); // outputs 10
      pers.sitDown(); // outputs 'Sitting down...'
    }
  ```

- Using mixins will grant access to certain properties & methods of the mixined type. However, different from inheritance, the base type will not be considered same as the mixined type.

- `with` keyword includes the properties and methods of a `mixin` into a class type.

- A class type can only inherit from one single other class, whereas it can have multiple mixins.
