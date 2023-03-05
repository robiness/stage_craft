# widget_stage

Help your widgets get the attention they deserve. <br />
Each widget gets its own stage where you can live manipulate it and see if it's behaving as expected.

## Overview

This package has three main classes you should know about:

### `WidgetStage`<br />

The WidgetStage represents the stage where you can manipulate your widget.<br />
This is the Widget you put in your app. <br />

It consists of a main area where the widget is displayed.
A ConfigurationBar where all the properties of the widget can get manipulated.
And a bar where all your widgets can be selected to put on stage.

### `WidgetStageData`<br />

The WidgetStageData contains all the information the `WidgetStage` needs to display your widget and to manipulate
it.<br />
You can give it a `name` and in the `builder` the actual widget gets returned.<br />

### `FieldConfigurator`<br />

To be able to manipulate your widget, you need to be able to change its properties.<br />
So for every type your widget on stage has, there has to be a corresponding `FieldConfigurator<T>` with that exact
type.<br />

Provided `FieldConfigurator`s are:<br />

`StringFieldConfigurator`<br />
`IntFieldConfigurator`<br />
`DoubleFieldConfigurator`<br />
`ColorFieldConfigurator`<br />

## Getting Started

For each widget you want to put on stage, create a new class which implements `WidgetStageData`.<br />
If the widget has a parameter of a type where there is no `FieldConfigurator` yet, you can easily create one and use it
afterwards.<br />

