# AppStuff Design

### Design Library of reusable, modern SwiftUI components

## Installation
Add this Swift package in Xcode using its Github repository url. (File > Swift Packages > Add Package Dependency...)

## Usage 

The following code demonstrates how simple it is to create a custom button that displays a loading indicator

```swift
import AppStuffDesign

VStack {
   ASDButton("Click Me") {
      // action handler..
   }
   .buttonStyle(.standard(), isLoading: $isLoading)
}
```

https://github.com/user-attachments/assets/6581904d-64a4-40c9-8a32-427ccd562a4b


## Design Catalogue

The Design Catalogue feature provides an intuitive and interactive way to explore the full range of components within the library.
Users can browse through all available elements, interact with them in real-time, and see firsthand how each component can be utilized. 
This makes it easier to understand the versatility and application of the components in various design scenarios.


https://github.com/user-attachments/assets/698507b8-26f0-4ae4-921c-5e8df6959184

