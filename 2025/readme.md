![Progress](https://img.shields.io/badge/progress-75%25-yellow)
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

💫 `@Bindable` makes Bindings to `@Observable`objects properties

## Lecture 7: Animations

Only changes can be animated. Animation shows the user smth that **have already happend**.

- view modifiers values changes - it happens only if the view is on screen
- views existance (called transition animation) - it happens only if views container already on screen
- shapes

💫 We can use `onAppear` to understand when our view is actually on screen and could be animated.

💫 `Shape` and `ViewModifier` could confirm to `Animatable`, where we can describe our custom animations.

### Types of animations

Explicit animations (`withAnimation`) do not override or prevent implicit animations (`.animation(...)`).

#### `.animation(Animation?, value: some Equatable)`

It declares the animation. It is the animation with the most priority. 

It only gonna change what's inside the modifier in terms of types (aka the order of view modifiers here matters a lot)

This modifier can be used with containers. They will propogate the animation to it's views.

Can supress the animation.

#### `withAnimation(Animation) {...} completion {...} `

💫 We can chain animations calling another `withAnimation` in completion.

`withAnimation` does not overwrite `.animation(...)`.

#### `withTransaction` + `.transaction(...)`

Operates on Transaction struct, where I can pass my specific data to decide do I need animation or not (ex. user clicked and caused navigation or it was triggered through code).

#### `Binding.animation(...)`

It's like we are wrapping all changes of this binding in `withAnimation`

#### `.transition(AnyTransition)`

Animates the appearing and disappearing of a view.

-----------------------------

#### `.matchedGeometryEffect(id: ID, in: Namespace)`

Special kind of transition.

Helps us to animate view "moving between containers". 

In generic case our only task is to make sure these views are not in the UI together at the same time. There are other possible use cases, but they are much less common (do research if you are interested)

#### `TimelineView` and other specific views

`TimelineView` gets a VuewBuilder in which we can read a context (ex. DateTime) and build the view the want.
