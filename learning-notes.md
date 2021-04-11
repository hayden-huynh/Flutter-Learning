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