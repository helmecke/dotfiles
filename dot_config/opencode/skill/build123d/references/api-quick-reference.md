# build123d API Quick Reference

## 1D Objects (BuildLine / Curve)

### Lines

```python
Line(start: VectorLike, end: VectorLike)
PolarLine(start: VectorLike, length: float, direction: VectorLike | float)
Polyline(*pts: VectorLike)
FilletPolyline(*pts: VectorLike, radius: float)
IntersectingLine(start: VectorLike, direction: VectorLike, surface)
```

### Arcs

```python
CenterArc(center: VectorLike, radius: float, start_angle: float, arc_size: float)
ThreePointArc(p1: VectorLike, p2: VectorLike, p3: VectorLike)
TangentArc(start: VectorLike, tangent: VectorLike, end: VectorLike)
RadiusArc(start: VectorLike, end: VectorLike, radius: float)
SagittaArc(start: VectorLike, end: VectorLike, sagitta: float)
JernArc(start: VectorLike, tangent: VectorLike, radius: float, arc_size: float)
```

### Curves

```python
Spline(*pts: VectorLike, tangents=None, periodic=False)
Bezier(*cpts: VectorLike)
Helix(pitch: float, height: float, radius: float, center=None, direction=Axis.Z)
```

### Special Curves

```python
Airfoil(naca: str, chord_length: float, num_points: int)
BlendCurve(start: VectorLike, end: VectorLike, tangents, tangent_scalars)
```

## 2D Objects (BuildSketch / Face)

### Basic Shapes

```python
Circle(radius: float, align=(Align.CENTER, Align.CENTER))
Ellipse(x_radius: float, y_radius: float, align=...)
Rectangle(width: float, height: float, align=...)
RectangleRounded(width: float, height: float, radius: float, align=...)
RegularPolygon(radius: float, side_count: int, align=...)
Polygon(*pts: VectorLike, align=...)
Triangle(a: float, b: float, C: float, align=...)
Trapezoid(width: float, height: float, left_side_angle: float, right_side_angle: float, align=...)
```

### Slots

```python
SlotArc(arc: Edge, height: float)
SlotCenterPoint(center: VectorLike, point: VectorLike, height: float)
SlotCenterToCenter(center_separation: float, height: float, rotation: float)
SlotOverall(width: float, height: float, rotation: float)
```

### Text

```python
Text(txt: str, font_size: float, font: str = "Arial", 
     font_style: FontStyle = FontStyle.REGULAR,
     align=(Align.CENTER, Align.CENTER))
```

### Drafting (Technical Drawings)

```python
Arrow(start: VectorLike, end: VectorLike, head_width: float)
ArrowHead(apex: VectorLike, direction: VectorLike, width: float)
DimensionLine(path: Edge, label: str, arrows=(True, True))
ExtensionLine(object_edge: Edge, offset: float, tolerance: float)
TechnicalDrawing(part, view_port_origin=...)
```

## 3D Objects (BuildPart / Solid)

### Primitives

```python
Box(length: float, width: float, height: float,
    align=(Align.CENTER, Align.CENTER, Align.MIN))
Cylinder(radius: float, height: float,
         align=(Align.CENTER, Align.CENTER, Align.MIN))
Sphere(radius: float, align=(Align.CENTER, Align.CENTER, Align.CENTER))
Cone(bottom_radius: float, top_radius: float, height: float, align=...)
Torus(major_radius: float, minor_radius: float, align=...)
Wedge(xsize: float, ysize: float, zsize: float, 
      xmin: float, zmin: float, xmax: float, zmax: float, align=...)
```

### Holes

```python
Hole(radius: float, depth: float = None)
CounterBoreHole(radius: float, counter_bore_radius: float, 
                counter_bore_depth: float, depth: float = None)
CounterSinkHole(radius: float, counter_sink_radius: float, depth: float = None)
```

## Operations

### 1D Operations

```python
add(*objects)                          # Combine curves
offset(distance: float, kind: Kind)    # Offset curve
mirror(about: Plane)                   # Mirror curve
scale(factor: float)                   # Scale curve
split(bisect_by: Plane | Face)         # Split curve
```

### 2D Operations

```python
add(*objects)                          # Union faces
fillet(*vertices_or_edges, radius: float)    # Fillet corners/edges
chamfer(*vertices_or_edges, length: float)   # Chamfer corners/edges
full_round(*edges, radius: float)      # Full-round fillet
make_face()                            # Close wires to face
make_hull()                            # Create convex hull
offset(amount: float, kind: Kind)      # Offset face
mirror(about: Plane)                   # Mirror face
scale(factor: float)                   # Scale face
split(bisect_by: Plane | Face)         # Split face
```

### 3D Operations

```python
add(*objects)                          # Union solids
extrude(amount: float, both=False, taper: float = 0, dir=None)
revolve(axis: Axis = Axis.Z, angle: float = 360)
loft(profiles: list, ruled=False)
sweep(profiles: Face | Wire, path: Wire | Edge)
fillet(*edges, radius: float)          # Fillet edges
chamfer(*edges, length: float, length2=None)  # Chamfer edges
draft(angle: float, neutral_plane: Plane, *entities)  # Draft faces
offset(amount: float, kind: Kind = Kind.ARC)  # Offset/shell solid
mirror(about: Plane)                   # Mirror solid
scale(factor: float)                   # Scale solid
section(height: float, plane: Plane = Plane.XY)  # Section cut
split(bisect_by: Plane | Face)         # Split solid
make_brake_formed(thickness: float, bend_radii: dict)  # Sheet metal
```

## Selectors

### Basic Selectors

```python
obj.vertices()  # ShapeList[Vertex]
obj.edges()     # ShapeList[Edge]
obj.wires()     # ShapeList[Wire]
obj.faces()     # ShapeList[Face]
obj.solids()    # ShapeList[Solid]
obj.shells()    # ShapeList[Shell]
```

### ShapeList Methods

```python
# Filtering
.filter_by(condition: Callable | Axis | Plane | GeomType)
.filter_by_position(axis: Axis, minimum: float, maximum: float)

# Sorting
.sort_by(key: Axis | SortBy | Callable)

# Grouping
.group_by(axis: Axis | SortBy | Callable) -> list[ShapeList]

# Selection
.first()       # First element
.last()        # Last element
[index]        # Index access
[start:end]    # Slice access
```

### Selector Operators

```python
shapes > Axis.Z          # Sort ascending by Z
shapes < Axis.Z          # Sort descending by Z
shapes >> Axis.Z         # Group by Z, return max group
shapes << Axis.Z         # Group by Z, return min group
shapes | GeomType.PLANE  # Filter by geometry type
shapes | Plane.XY        # Filter by plane
```

### GeomType Enum

```python
GeomType.PLANE
GeomType.CYLINDER
GeomType.CONE
GeomType.SPHERE
GeomType.TORUS
GeomType.BEZIER
GeomType.BSPLINE
GeomType.CIRCLE
GeomType.ELLIPSE
GeomType.HYPERBOLA
GeomType.PARABOLA
GeomType.LINE
```

### SortBy Enum

```python
SortBy.LENGTH
SortBy.RADIUS
SortBy.AREA
SortBy.VOLUME
SortBy.DISTANCE
```

## Location and Positioning

### Location Classes

```python
Pos(x: float, y: float = 0, z: float = 0)        # Position
Rot(x: float = 0, y: float = 0, z: float = 0)    # Rotation (degrees)
Location(pos: Vector = Vector(0,0,0), 
         rot: Vector = Vector(0,0,0))             # Combined

# Combine with multiplication
loc = Pos(10, 5) * Rot(45, 0, 0)
```

### Planes

```python
Plane.XY      # Z-up plane
Plane.XZ      # Y-up plane  
Plane.YZ      # X-up plane
Plane.front   # Same as XZ
Plane.back    # -XZ
Plane.left    # -YZ
Plane.right   # YZ
Plane.top     # XY
Plane.bottom  # -XY

# Transform planes
plane = Plane.XY * Pos(10, 0, 5)
plane = Plane.XY.offset(10)          # Offset along normal
plane = Plane(origin, x_dir, z_dir)  # Custom plane
```

### Location Contexts (Builder Mode)

```python
Locations(*locations: Location | VectorLike)
GridLocations(x_spacing: float, y_spacing: float, 
              x_count: int, y_count: int)
PolarLocations(radius: float, count: int, 
               start_angle: float = 0, 
               end_angle: float = 360,
               rotate: bool = True)
HexLocations(spacing: float, count: int)
```

## Alignment

### Align Enum

```python
Align.MIN      # Align to minimum
Align.CENTER   # Align to center
Align.MAX      # Align to maximum
```

### Usage

```python
# 2D alignment (x, y)
Rectangle(10, 5, align=(Align.CENTER, Align.MIN))
Circle(3, align=(Align.MAX, Align.MAX))

# 3D alignment (x, y, z)
Box(10, 10, 5, align=(Align.CENTER, Align.CENTER, Align.MIN))
Cylinder(5, 10, align=(Align.MIN, Align.MIN, Align.CENTER))
```

## Mode Enum (Builder Mode)

```python
Mode.ADD        # Union (default)
Mode.SUBTRACT   # Difference
Mode.INTERSECT  # Intersection
Mode.REPLACE    # Replace all pending
Mode.PRIVATE    # Create but don't add to context
```

## Edge/Wire Operators

```python
edge @ 0.5           # Position at 50% along edge (returns Vector)
edge % 0.5           # Tangent at 50% along edge (returns Vector)
edge ^ 0.5           # Location at 50% along edge (returns Location)

# Methods
edge.position_at(t: float) -> Vector
edge.tangent_at(t: float) -> Vector
edge.location_at(t: float) -> Location
```

## Import/Export

```python
# Export
export_step(obj, "file.step")
export_stl(obj, "file.stl", tolerance=0.1, angular_tolerance=0.1)
export_brep(obj, "file.brep")
export_dxf(obj, "file.dxf")
export_svg(obj, "file.svg")
export_stl(obj, "file.stl", tolerance=0.01)  # High quality
export_gltf(obj, "file.gltf")
export_vrml(obj, "file.wrl")
export_vtp(obj, "file.vtp")

# Import
obj = import_step("file.step")
obj = import_brep("file.brep")
obj = import_svg("file.svg")
obj = import_dxf("file.dxf")
obj = import_stl("file.stl")
```

## Useful Properties

### Shape Properties

```python
# Common to all shapes
obj.volume          # Volume (for solids)
obj.area            # Surface area
obj.bounding_box()  # BoundingBox object
obj.center()        # Center of mass/geometry
obj.is_valid()      # Validity check

# Edge-specific
edge.length         # Edge length
edge.radius         # Radius (if circular)
edge.arc_center     # Arc center (if circular)

# Face-specific
face.area           # Face area
face.normal_at()    # Normal vector
face.center()       # Face center

# Vertex-specific
vertex.X, vertex.Y, vertex.Z  # Coordinates
vertex.to_tuple()   # (x, y, z)
```

### BoundingBox

```python
bbox = obj.bounding_box()
bbox.min            # Minimum corner Vector
bbox.max            # Maximum corner Vector
bbox.size           # Size Vector
bbox.center()       # Center point
```

## Vector Operations

```python
v = Vector(x, y, z)
v1 + v2             # Addition
v1 - v2             # Subtraction
v * scalar          # Scalar multiplication
v / scalar          # Scalar division
v.dot(v2)           # Dot product
v.cross(v2)         # Cross product
v.length            # Magnitude
v.normalized()      # Unit vector
v.angle_between(v2) # Angle in degrees
```

## Axis

```python
Axis.X              # X axis
Axis.Y              # Y axis
Axis.Z              # Z axis

# Custom axis
Axis((0, 0, 0), (1, 0, 0))  # Origin, direction
```

## Common Workflows

### Sketch → Extrude

```python
# Algebra mode
sketch = Circle(10)
sketch -= Pos(5, 0) * Circle(3)
part = extrude(sketch, amount=20)

# Builder mode
with BuildPart():
    with BuildSketch():
        Circle(10)
        with Locations((5, 0)):
            Circle(3, mode=Mode.SUBTRACT)
    extrude(amount=20)
```

### Sketch → Revolve

```python
# Algebra mode
profile = Rectangle(20, 10, align=(Align.MIN, Align.CENTER))
part = revolve(profile, axis=Axis.Y, angle=360)

# Builder mode
with BuildPart():
    with BuildSketch():
        Rectangle(20, 10, align=(Align.MIN, Align.CENTER))
    revolve(axis=Axis.Y)
```

### Loft Between Profiles

```python
# Algebra mode
bottom = Circle(10)
middle = Rectangle(15, 15)
top = Circle(5)
part = loft([bottom, middle, top])

# Builder mode
with BuildPart():
    with BuildSketch():
        Circle(10)
    with BuildSketch(Plane.XY.offset(10)):
        Rectangle(15, 15)
    with BuildSketch(Plane.XY.offset(20)):
        Circle(5)
    loft()
```

### Sweep Profile Along Path

```python
# Create path
with BuildLine() as path_builder:
    Line((0, 0, 0), (10, 0, 0))
    TangentArc(path_builder @ 1, path_builder % 1, 90)
path = path_builder.wires()[0]

# Create profile
profile = Circle(1)

# Sweep
part = sweep(profile, path)
```

## Tips

### Performance
- Use appropriate tolerance for exports
- Combine operations where possible
- Cache complex computations
- Use `make_hull()` instead of many unions

### Debugging
- Use `show()` with ocp_vscode
- Check `.is_valid()` on shapes
- Inspect `.volume`, `.area`, `.length`
- Count topology: `len(obj.faces())`

### Best Practices
- Use clear variable names
- Document complex selector chains
- Keep Builder contexts shallow
- Export to STEP for CAD interchange
- Export to STL for 3D printing
