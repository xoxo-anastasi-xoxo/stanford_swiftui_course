![Progress](https://img.shields.io/badge/progress-3%25-red)
# CS193p Spring 2025

https://cs193p.sites.stanford.edu/2025

## Lecture 1: Getting Started with SwiftUI

**Navigator** - XCode left side

**Inspector** - XCode right side

### Lego Terminology

Let's introduce a funny terminology in order to flow easier through the course.

`Text`, `Image` - lego bricks

`ContentView` - lego helicopter (standalone finished figure)

`VStack` - instructions manual

`@ViewBuilder` - plastic bag with bricks (like the one's I see in the new box of lego)

### Recurrent structure of `View` protocol
`Never` is also conforming to `View` protocol. It helps to end recursion: `Text` is a `View` with `Body` = `Never`.
