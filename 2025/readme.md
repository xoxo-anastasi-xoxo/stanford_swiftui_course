![Progress](https://img.shields.io/badge/progress-37%25-yellow)
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


## Lecture 5: Layout & Data Flow

‼️ Rule of thumb: views generally want to behaive the same in terms of layout (in terms of their flexibility) no matter what data they get.

### Layout Priority inside VStack/HStack

SwiftUI layout strategy is build to do not overlap (overlapping takes effort)

#### Overall algorithm:

1. Take the least flexible view
2. Give it all the space you have
3. Substract that space of yours and go to step 1, if you have more views

#### What is view flexibility?

**inflexible** - `Image` or `Text` or some other view with fixed size

**medium flexible** - `Text("...").minimumScaleFactor(X)` or `Image("...").resizable()`

**mostly flexible** - `Circle` - uses all the space, but constrained to `aspectRatio`

**fully flexible** - `Rectangle`, `Spacer` - takes all the space

💫 `Divider` - fully flexible on one axis and inflexible in other.

💫 We can influence layout order by setting `.layoutPriority(Double)`.

💫 Stacks itself inherit their flexibility from its content.

### All the views confirming to `Layout` Protocol

The simplest are `VStack` and `HStack`.

#### `ZStack`

💫 `ZStack` itself "inherits" the flexibility from its content (the biggest, most flexible view dictates the rules).

`.overlay(...)` acts similar to ZStack of only two elements. But its flexibility and size fully depend only on the main view. And `.background(...)` is the same!

#### `LazyVStack`&`LazyHStack`

Don't layout if its out of the screen.

💫 Lazy stacks try to take as little space as possible on their main axis and try to take all space on the other axis, iow main is inflexible, auxiliary is fully flexible.

#### `LazyVGrid`&`LazyHGrid` vs. `Grid`+`GridRow`

Grid is a table, but VGrid and HGrid are not.

💫 For `Grid` we have a family of `.grid*` modifiers to ensure right behaviour.

#### `ScrollView`

💫 Again, we have a family of `.scroll*` modifiers to ensure right behaviour. But we rarely need them.

#### `ViewThatFits`

Chooses one best view to show (depending on the space provided). Great thing for conditional layout in iPhone/iPad situation.

#### Other

`Form` - editable items like in Settings

`List` - selectable items like in Settings

`DisclosureGroup` - toggle item

`OutlineGroup` - toggle item for a tree structure (like file system)

### Some view modifiers important for layout

#### `.padding(...)`

The view, returned by it, will inherit the flexibility from its original view.

In terms of participation in layouting - `.padding(...)` takes its space first and than gives the rest to the main view.

### Data Flow

Some not really strict catigorisation:

**data in** - its read-only data that we receive (read-only in terms that we'll make a copy to modify it and will not effect the data originally provided) // for views it's props, state and environment (most of the time)

**data owned** - we are the source of thuth

**data in/out** - we received it and can modify

**data out** - its data that we don't store (aka don't own) but pass somewhere

💫 `@State` never holds actual data model, because its thrown away as soon as the view disappears. `@State` is strictly UI current state (ex. current search string). `@State` should be always `private`

💫 `@Binding` allows us to pass data owned by us to other views for future modification. `@Binding` is never `private`

----

💫 `@Observable` is `@Binding` but for classes

💫 closures are refs because they need to store their captured variables somewhere.

