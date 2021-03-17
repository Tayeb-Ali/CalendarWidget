# Calendar Widget - IOS.

## How does it work: 
HostApp is the folder that has most of the logic for the app and 
some shared/common components for the app and widget.
The host app is responsible to save any user input like text color, 
font, alignment, etc. Then the widget will retrieve these user input 
details and render the widget view.
Rendering is dictated by the iOS itself.
## WidgetManager: 
To manage the user input regarding any widget configuration.
It’s important to understand that the WidgetConfigurator is a 
class that handles saving and persisting your data.
This configurator class is embedded into the Apps4World 
framework, to make your job easier and less complicated code.
## CalendarWidgetView:
 is the main view for the widget. This view 
is being shared between the app and the widget itself.All the text, colors, image is being used by this view. Any 
changes that you may want to do to your widget, you should do 
them here.
## MainContentView:
 is the main view of the application. Here you 
have the widget view mentioned above, then all the modifiers/
configurations for the widget.
If you want to add more modifiers, like font size, then you should 
add them here, then store and share data for these new 
modifiers.
To save new configurations, make sure to use the 
<b>WidgetConfigurator.WidgetDataType.custom</b> as the key for 
your data.
The data type must be a dictionary.
Example:
```
let newConfiguration: [WidgetConfigurator.WidgetDataType: Any] = [ 
 .custom : ["fontSize": 12], .... /// make sure to other configs as well
] 
```
super.updateWidgetConfigurations(data: newConfiguration)
The example above will be invoked in the existing method 
named:

```
func updateWidgetConfigurations(data:
[WidgetConfigurator.WidgetDataType : Any]? = nil)
```
## AppWidget: 
> This is the main class for the widget itself. There is not much to 
do in this class, unless you want to change the display name of 
your widget, description or widget sizes.

## WHAT DOES THIS PRODUCT OFFER YOU
 > You will be able to do all kinds of UI changes, however, to make it easier for developers, the “heavy-lifting” logic of saving and persisting data that is being shared with the widget, is embedded into our private framework. No source code for the framework, but it’s very flexible in terms of adding new data. 

 # YOU MUST MAKE THESE CHANGES :
 - 1. Create a free account on Unsplash website 
The app is using Unsplash services to fetch images. You can 
create an account here: https://unsplash.com/developers
Register your app, get your App Keys and replace them with the 
one in AppConfig.swift
- 2. Replace the Bundle Identifier and App Group Id 
This step is very important. You must replace the app group ID in 
Xcode then in AppConfig.swift
