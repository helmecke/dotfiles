# Builder Mode vs Algebra Mode Comparison

## Overview

build123d offers two distinct programming paradigms. Understanding when to use each mode is critical for writing clean, maintainable CAD code.

## Detailed Comparison

### Philosophy

**Algebra Mode:**
- Objects are explicit variables
- State is managed by the developer
- Operations create new objects (immutable style)
- Transforms applied manually to each object
- Similar to functional programming

**Builder Mode:**
- Objects added to implicit context
- State managed by context managers
- Operations modify pending objects
- Transforms applied to all children in context
- Similar to domain-specific languages

### Syntax Examples

**Algebra Mode:**
```python
# Create and manipulate explicitly
circle = Circle(10)
circle -= Pos(5, 0) * Circle(3)
part = extrude(circle, amount=5)
part += Pos(0, 0, 5) * Cylinder(4, 3)
```

**Builder Mode:**
```python
# Create within contexts
with BuildPart() as part_context:
    with BuildSketch():
        Circle(10)
        with Locations((5, 0)):
            Circle(3, mode=Mode.SUBTRACT)
    extrude(amount=5)
    Cylinder(4, 3)
```

### Location Handling

**Algebra Mode - Manual:**
```python
# Must transform each object
hole1 = Pos(10, 0, 0) * Cylinder(2, 10)
hole2 = Pos(-10, 0, 0) * Cylinder(2, 10)
hole3 = Pos(0, 10, 0) * Cylinder(2, 10)
part = part - hole1 - hole2 - hole3
```

**Builder Mode - Contextual:**
```python
# Transform applies to all children
with Locations((10, 0, 0), (-10, 0, 0), (0, 10, 0)):
    Cylinder(2, 10, mode=Mode.SUBTRACT)
```

### Boolean Operations

**Algebra Mode - Operators:**
```python
union = part1 + part2
difference = part1 - part2
intersection = part1 & part2
```

**Builder Mode - Mode Parameter:**
```python
with BuildPart():
    Box(10, 10, 10)  # mode=Mode.ADD (default)
    Cylinder(3, 15, mode=Mode.SUBTRACT)
    Sphere(4, mode=Mode.INTERSECT)
```

## When to Use Each Mode

### Use Algebra Mode When:

✅ Creating simple, direct models
✅ Prototyping and experimenting
✅ Need explicit control over every object
✅ Working with simple transforms
✅ Building non-hierarchical structures
✅ Prefer functional programming style
✅ Want to see all objects as variables

**Example - Simple bracket:**
```python
base = Box(50, 30, 5)
base -= Pos(40, 15, 0) * Hole(4, 5)
base -= Pos(10, 15, 0) * Hole(4, 5)
arm = Pos(0, 0, 5) * Box(10, 30, 20)
bracket = base + arm
```

### Use Builder Mode When:

✅ Creating complex assemblies
✅ Using pattern locations (GridLocations, PolarLocations)
✅ Building hierarchical structures
✅ Need context-aware positioning
✅ Working with many similar features
✅ Creating reusable parametric objects
✅ Prefer declarative style

**Example - Complex assembly:**
```python
with BuildPart() as assembly:
    # Base plate
    with BuildSketch():
        Rectangle(100, 100)
    extrude(amount=5)
    
    # Pattern of mounting holes
    with Locations(Plane.XY.offset(5)):
        with GridLocations(80, 80, 2, 2):
            CounterSinkHole(4, 8)
    
    # Array of posts
    with PolarLocations(radius=30, count=8):
        Cylinder(5, 20)
```

## Mixing Modes (Anti-Pattern)

❌ **Don't mix modes in the same construction:**

```python
# BAD - mixing modes
with BuildPart():
    box = Box(10, 10, 10)  # Creates in context
    cyl = Cylinder(5, 15)  # Creates in context
    result = box + cyl     # Algebra mode on Builder objects
```

✅ **Stay within one mode:**

```python
# GOOD - consistent Builder mode
with BuildPart():
    Box(10, 10, 10)
    Cylinder(5, 15, mode=Mode.ADD)
```

```python
# GOOD - consistent Algebra mode
box = Box(10, 10, 10)
cyl = Cylinder(5, 15)
result = box + cyl
```

## Converting Between Modes

Objects created in one mode can be used in the other:

**Builder to Algebra:**
```python
with BuildPart() as builder:
    Box(10, 10, 10)
    Cylinder(5, 15)

# Extract result for Algebra mode
part = builder.part
part += Sphere(8)  # Continue in Algebra mode
```

**Algebra to Builder:**
```python
base = Box(20, 20, 5)
holes = Pos(10, 10, 0) * Cylinder(2, 5)

with BuildPart() as assembly:
    add(base)  # Add pre-made object
    add(holes, mode=Mode.SUBTRACT)
```

## Mode Selection Decision Tree

```
Start
  │
  ├─ Need pattern locations? ──YES──> Builder Mode
  │   (GridLocations, PolarLocations)
  │
  ├─ Complex assembly? ──YES──> Builder Mode
  │   (Multiple parts, hierarchical)
  │
  ├─ Many similar features? ──YES──> Builder Mode
  │   (Repeated holes, posts, etc.)
  │
  ├─ Prefer explicit variables? ──YES──> Algebra Mode
  │
  ├─ Simple model? ──YES──> Algebra Mode
  │
  └─ Prototyping? ──YES──> Algebra Mode (faster iteration)
```

## Performance Considerations

**Both modes have similar performance** - the choice is primarily about:
- Code readability
- Maintenance
- Personal preference
- Problem structure

The OpenCascade kernel handles both modes identically after construction.

## Learning Path Recommendation

1. **Start with Algebra Mode** - More intuitive for Python developers
2. **Learn selectors** - Work in both modes
3. **Explore Builder Mode** - When Algebra feels repetitive
4. **Use both** - Choose based on the problem

## Common Conversions

### Algebra → Builder

**Before (Algebra):**
```python
rect = Rectangle(20, 10)
rect -= Pos(15, 5) * Circle(2)
rect -= Pos(5, 5) * Circle(2)
part = extrude(rect, amount=5)
part = fillet(part.edges().filter_by(Axis.Z), radius=0.5)
```

**After (Builder):**
```python
with BuildPart():
    with BuildSketch():
        Rectangle(20, 10)
        with Locations((15, 5), (5, 5)):
            Circle(2, mode=Mode.SUBTRACT)
    extrude(amount=5)
    fillet(edges().filter_by(Axis.Z), radius=0.5)
```

### Builder → Algebra

**Before (Builder):**
```python
with BuildPart() as p:
    Box(10, 10, 10)
    with Locations((5, 5, 10)):
        Cylinder(2, 5)
```

**After (Algebra):**
```python
part = Box(10, 10, 10)
part += Pos(5, 5, 10) * Cylinder(2, 5)
```

## Best Practices Summary

**Algebra Mode:**
- Use clear variable names
- Chain operations thoughtfully
- Keep transforms visible
- Document complex expressions

**Builder Mode:**
- Keep contexts shallow (2-3 levels max)
- Use meaningful context names
- Specify mode explicitly when not ADD
- Comment context purpose

**Both Modes:**
- Stay consistent within a construction
- Extract to functions for reusability
- Use selectors effectively
- Export format doesn't depend on mode
