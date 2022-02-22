# hackpsu

## Contents
1. [Getting Started](#getting-started)
2. [Data Models](#data-models)
    - [JSON Objects](#json-objects)

## Getting Started

### Run in Dev Environment

```shell
flutter run --flavor dev -t lib/main_dev.dart
```

### Run JSON Serialization

```shell
flutter pub run build_runner build
```

Run this script to generate JSON serializable annotated objects.


## Data Models

### JSON Objects

To reduce boilerplate code and enforce type safety, we use the JSON
annotation and JSON Serializable annotations on data models.

Import the following package to start annotating a class:

```dart
import 'package:json_annotation/json_annotation.dart';
```

For the library to work, it uses code generation to generate JSON serialization.
Include this line at the top of the file after imports. The name specified
will be generated.

**Note**: To be consistent, use the same name as the current file.

```dart
part '<filename>.g.dart';
```

Run build_runner to generate the code:
```shell
flutter pub run build_runner build
```

Example:

```dart
@JsonSerializable(fieldRename: FieldRename.snake)
class Model {
  Model({
    @required firstName,
    @required uid,
    @required time,
  });
  
  factory Model.fromJson(Map<String, dynamic> json) => 
          _$ModelFromJson(json);
  
  Map<String, dynamic> toJson() => 
          _$ModelToJson(this);
  
  static DateTime _timeFromJson(int int) => 
          DateTime.fromMillisecondsSinceEpoch(int);
  
  final String firstName;
  final String uid;
  
  @JsonKey(fromJson: _timeFromJson)
  final DateTime time;
}
```

#### JsonSerializable

`JsonSerializable` is an annotation that defines the class to serialize.

| Recommended Inputs / `type` | Description |
| ------------------ | ----------- |
| fieldRename / `FieldRename` | Renames fields defined as property into its appropriate field name in the json. If the json field being parsed is `first_name` then `first_name` will be used when serializing a value for the `firstName` property |
| createFactory / `bool` | Determines if a factory should be created to generate deserialized json |
| createToJson / `bool` | Determines if a function to create a json object should be generated |

#### JsonKey

`JsonKey` is an annotation that defines options for a specific json field

| Recommended Inputs / `type` | Description |
| --------------------------- | ----------- |
| name / `String` | The name that appears in the original json object. `fieldRename` is only used if all fields follow the same naming convention. Otherwise, use this input to specify the name of the json field to parse. |
| fromJson / `Function` | A function that will be used to deserialize a specific field. Useful for converting UNIX timestamps to DateTime. |
| toJson / `Function` | A function that will be used to serialize a specific field. Useful for converting DateTime back to original json format. |

### Equatable

`Equatable` is a base class used to compare two objects. It is useful when using bloc/cubit and comparing 
objects to determine when to build.

Import:
```dart
import 'package:equatable/equatable.dart';
```

Example:
```dart
class Model extends Equatable {
  Model({
    @required name,
    @required uid,
  });
  
  final String name;
  final String uid;
  
  @override
  List<Object> get props => [name, uid];
}
```

| Required Overrides / `type` | Description |
| ------------------ | ----------- |
| props / `List<Object>` | Returns a list of properties that will be used to compare with other objects of a similar type. |

## Widgets

Below are a list of widgets to reduce boilerplate code and encourage reusable widgets.

### Using the Widgets

The widgets below can be used as base widgets such that you can create wrappers over current
implementations and customize base functionalities and styles. The purpose of these widgets are to
abstract common functionalities and speed up development time. Some widgets abstract over state management
and can be extended through type generics.

### Default Text

Import:
```dart
import 'relative/to/lib/widget/default_text.dart';
```

Example:
```dart
DefaultText(
  "Example text",
  color: Colors.black,
  textLevel: TextLevel.h1,
);
```

Inputs:

| Input / `type` | Required | Description |
| -------------- | -------- | ----------- |
| text / `String` | Required | The only default input required to be defined first before any other inputs. |
| textLevel / `TextLevel` | Optional | A `TextLevel` selects a specific text style used for different levels of texts. |
| weight / `FontWeight` | Optional | The weight of the font being displayed. |
| fontSize / `double` | Optional | The fontSize of the displayed text. |
| maxLines / `int` | Optional | The maximum number of lines before an overflow is used. |
| textAlign / `TextAlign` | Optional | The position of text along the main axis. |
| letterSpacing / `double` | Optional | Spacing between each individual letter. |
| color / `Color` | Optional | Color of the text. |

### Input

```dart
import 'relative/to/lib/widgets/input.dart';
```

#### Base Input

Example:
```dart
Input(
  label: "Label",
  password: false,
  inputType: TextInputType.text,
  autocorrect: true,
  onChanged: (newValue) {
    // send newValue to bloc/cubit
    dispatch(newValue)
  },
);
```

Inputs:

| Input / `type` | Required | Description |
| -------------- | -------- | ----------- |
| label / `String` | Required | The placeholder text within the input field. |
| onChanged / `Function` | Required | The function that will be called when the component's state changes. |
 
#### Password Input

Implements the base Input widget above. Provides default styling to ensure password input hides text 
and toggles visibility.

Example:
```dart
PasswordInput(
  label: "Password",
  onChanged: (newPassword) {
    // send password to bloc/cubit
    dispatch(newPassword)
  },
);
```

#### Controlled Input

Provides an abstraction over `BlocBuilder` and assumes that a `BlocProvider` is defined before inserting the Widget.
The output of `builder` should be a widget that extends or implements the `Input` widget above.

Example:
```dart
ControlledInput<Cubit, State>(
  buildWhen: (oldState, newState) => 
      oldState.property != newState.property,
  builder: (dispatch, state) {
    return PasswordInput(
      label: "Password",
      onChange: (newPassword) {
        dispatch.passwordChanged(newPassword)  
      } 
    );
  }
);
```

Inputs:

| Input / `type` | Required | Description |
| -------------- | -------- | ----------- |
| Cubit / `Cubit` | Required | The cubit injected into the type generics must be the cubit initialized using the `BlocProvider` and will be used by the builder. |
| State / `BaseModel` | Required | The state data model. This model must extend the `BaseModel` for consistency and implement an equatable model. |
| buildWhen / `Function` | Required | A callback used to figure out when the component defined should be rebuilt by Flutter. |
| builder / `Function` | Required | The function used to render a Flutter widget. The function must return an `Input` object. |

Builder:

The builder exposes 2 parameters: `dispatch` and `state`. `dispatch` is a connection to the cubit attached and exposes the functions
defined in the cubit. It is used to `dispatch` events or state changes to the bloc/cubit defined. `state` is the current state kept by the cubit
it holds the states that are updated and will be updated.

### Screen

`Screen` is an abstraction over a `Scaffold` and exposes common functionalities to structure a page. 

Import:
```dart
import 'relative/to/lib/widgets/screen.dart';
```

Example:
```dart
Screen(
  withDismissKeyboard: true,
  withBottomNavigation: true,
  backgroundColor: Colors.white,
  body: const Page(),
);
```

Inputs:

| Input / `type` | Required | Description |
| -------------- | -------- | ----------- |
| withDismissKeyboard / `bool` | Optional | If `true`, when the user clicks away from an input while focusing on it, the keyboard will dismiss. |
| withBottomNavigation / `bool` | Required | If `true`, a bottom navigation will be used for the page. |
| backgroundColor / `Color` | Optional | The color of the screen's background. |
| body / `Widget` | Required | The widget to render on the page.

### Button
The `Button` widget implements a convenient way to create different types of button through one interface. It groups
implementations of Flutter's `ElevatedButton`, `TextButton`, and `IconButton` along with all its `icon` variants into
one widget. The widget exposes a `ButtonVariant` enum to select the type of button and looks for the `icon` parameter
to be set to determine if an `icon` variant should be used.

Import:
```dart
import 'relative/to/lib/widgets/button.dart';
```

Example:
```dart
Button(
  variant: ButtonVariant.TextButton,
  onPressed: () {
    // define action
  },
  child: DefaultText(
    "Text"
  ),
);
```

Inputs:

| Input / `type` | Required | Description |
| -------------- | -------- | ----------- |
| variant / `ButtonVariant` | Required | The `ButtonVariant` that should be rendered. |
| onPressed / `Function` | Required | A callback when the button is pressed. |
| child / `DefaultText` | Optional | The text that will be shown together with the widget. |
| style / `ButtonStyle` | Optional | The style of the button, read the [documentation](https://api.flutter.dev/flutter/material/ButtonStyle-class.html) for more information. |
| icon / `Widget` | Optional | The icon to show together with the button; triggers the use of `icon` variants. |
| iconSize / `double` | Optional | The size of the icon. |
| color / `Color` | Optional | Color of the icon when used together with `ButtonVariant.IconButton`. |

## State Management

For the purpose of keeping business logic and frontend code separate, the Bloc pattern is used. The bloc pattern
is an events-based state management system similar to `Redux` or a `React Reducer` where a particular action is
defined and states will change based on the action. For more simple applications, like storing changes in text inputs
or managing single states, a `Cubit` can be used instead, which is similar to a `React useState`. 

### Bloc

To properly setup a bloc, there 3 main components:

1. Bloc Definition
2. Bloc Events
3. States

Each component is responsible for different aspects of the bloc pattern: `States` store the structure and model of 
the state being managed, `Events` are actions that can be taken to update these states, and `Bloc Definition` provides an
interface to provide these events and keep track of the states.

### Cubit

For simple state management patterns, a cubit exposes functions that are accessible to update states. State in a cubit
can either be a single state component, or a class containing multiple nested states. Although a cubit can act like a 
bloc as well, it is anti-pattern to use cubits for more complex state management especially those
that involve multiple steps or future states depending on previous states. It is easier to control a progression
of states using the `Events` that a bloc exposes instead of calling functions from a cubit.

### Repository

A repository is an interface to the data layer of an application. A repository should only have one purpose and control
one part of the API functionality. For example, API calls for gathering user information should be kept separate from API
calls to authentication. This way, each repository can be maintained independently, reused, and extended.
Repositories can be used as a bridge between a state management (bloc or cubit) and the
specific API calls. Repositories should be initialized in the `app_entry` file under a `RepositoryProvider`. If
the repository is only used for specific parts of the application, they can also be wrapped around portions
that need the repository instead of the entire app.

Due to the independent nature of repositories, they can be injected into a cubit or a bloc during initialization of 
the cubit or bloc. Make sure that the `RepositoryProvider` is defined first before initializing a bloc or cubit.

## Design Patterns

### Reusable and Extensible
The widgets and bloc or cubit pattern enforces a common theme: reusable and extensible components. The base
widgets are implementations over native Flutter widgets and are meant to expose some of the common features. 
In some cases, more styling options need to be added since not all named parameters are exported from the original
Flutter widget, but the change should never affect current implementations of the widget. Wrapping widgets for specific
use cases is recommended to reduce duplicated code and to share a uniform widget throughout the app.

### Bloc and Cubit
A bloc should only be used for complex state management applications such as multi-stage state updates where each
step can be emitted as a different event back to the UI or to keep states across multiple pages. A cubit should be used
when state updates are less dependent on previous states and do not require complex updates of states.

### Inputs
The easiest way to hook up a `TextField` is to use a controller. Although they are easy to use
and require less of a structure, managing the controllers themselves can introduce a lot of unnecessary
boilerplate code. One important overlooked limitation of a `TextField` is that the controller will need
to be deallocated to prevent memory leaks when the widget is destroyed. To avoid the need to debug memory leaks,
a cubit can be used where the state can be updated when the `TextField` changes. This way, there will not be
any need to move values between the controller to functions that submit forms and validation can be easily done within
the cubit itself.

