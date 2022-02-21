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
| withDismissKeyboard / `bool` | Optional | If `true`, when the user clicks away from an input while focusing on an input, the keyboard will dismiss. |
| withBottomNavigation / `bool` | Required | If `true`, a bottom navigation will be used for the page. |
| backgroundColor / `Color` | Optional | The color of the screen's background. |
| body / `Widget` | Required | The widget to render on the page.
