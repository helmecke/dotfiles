# pyright: basic
"""
Builder Mode Example: Parametric Enclosure Box

This example demonstrates build123d Builder Mode for creating a more complex
parametric enclosure box with features like:
- Pattern locations for mounting holes
- Hierarchical construction with nested contexts
- Context-aware positioning
- Implicit state management

Key Builder Mode patterns shown:
- with BuildPart/BuildSketch/BuildLine contexts
- Location contexts (GridLocations, PolarLocations)
- Mode parameter for boolean operations
- Selectors accessing pending objects
- Plane positioning for features

The enclosure has:
- Base box with lid mounting holes
- Ventilation slots
- Corner mounting posts
- Access port
"""

from build123d import *  # type: ignore

# Parameters
BOX_LENGTH = 100
BOX_WIDTH = 80
BOX_HEIGHT = 50
WALL_THICKNESS = 3

MOUNTING_HOLE_DIA = 3
MOUNTING_POST_DIA = 6
MOUNTING_POST_HEIGHT = 15

VENT_SLOT_WIDTH = 2
VENT_SLOT_LENGTH = 30
VENT_SLOT_SPACING = 5
VENT_SLOT_COUNT = 5

ACCESS_PORT_DIA = 20
ACCESS_PORT_POSITION = (BOX_LENGTH / 3, 0, BOX_HEIGHT / 2)

LID_SCREW_DIA = 2.5
LID_SCREW_INSET = 10


def create_enclosure(
    length=BOX_LENGTH,
    width=BOX_WIDTH,
    height=BOX_HEIGHT,
    wall_thickness=WALL_THICKNESS,
    mounting_hole_dia=MOUNTING_HOLE_DIA,
    mounting_post_dia=MOUNTING_POST_DIA,
    mounting_post_height=MOUNTING_POST_HEIGHT,
    vent_slot_width=VENT_SLOT_WIDTH,
    vent_slot_length=VENT_SLOT_LENGTH,
    vent_slot_spacing=VENT_SLOT_SPACING,
    vent_slot_count=VENT_SLOT_COUNT,
    access_port_dia=ACCESS_PORT_DIA,
    access_port_position=ACCESS_PORT_POSITION,
    lid_screw_dia=LID_SCREW_DIA,
    lid_screw_inset=LID_SCREW_INSET,
):
    """
    Create parametric enclosure using Builder Mode.

    Demonstrates hierarchical construction with nested contexts
    and context-aware positioning.

    Returns:
        Solid: The complete enclosure
    """

    # Main build context for the enclosure
    with BuildPart() as enclosure:
        # Step 1: Create hollow box (base geometry)
        Box(length, width, height, align=(Align.CENTER, Align.CENTER, Align.MIN))

        # Hollow out the interior
        with Locations(Plane.XY.offset(wall_thickness)):
            Box(
                length - 2 * wall_thickness,
                width - 2 * wall_thickness,
                height - wall_thickness + 1,  # +1 to ensure open top
                align=(Align.CENTER, Align.CENTER, Align.MIN),
                mode=Mode.SUBTRACT,
            )

        # Step 2: Add mounting posts at corners
        # GridLocations creates 4 positions in a grid
        corner_spacing_x = length - 2 * lid_screw_inset
        corner_spacing_y = width - 2 * lid_screw_inset

        with Locations(Plane.XY.offset(wall_thickness)):
            with GridLocations(corner_spacing_x, corner_spacing_y, 2, 2):
                # Each cylinder is created at all 4 grid locations
                Cylinder(
                    mounting_post_dia / 2,
                    mounting_post_height,
                    align=(Align.CENTER, Align.CENTER, Align.MIN),
                )

                # Holes through the posts for screws
                Hole(mounting_hole_dia / 2, mounting_post_height)

        # Step 3: Add ventilation slots on side
        # Position on the YZ plane (side face)
        with BuildSketch(Plane.YZ * Pos(length / 2, 0, 0)):  # type: ignore
            # Use a loop with explicit Locations for each slot
            for i in range(vent_slot_count):
                offset_y = (i - (vent_slot_count - 1) / 2) * (
                    vent_slot_length + vent_slot_spacing
                )
                with Locations((0, offset_y)):  # type: ignore
                    Rectangle(
                        wall_thickness + 2,  # +2 to ensure through hole
                        vent_slot_length,
                    )

        # Extrude cuts through the wall
        extrude(amount=-vent_slot_width / 2, both=True, mode=Mode.SUBTRACT)

        # Step 4: Add access port on front
        with BuildSketch(Plane.XZ * Pos(0, width / 2, 0)):  # type: ignore
            Circle(access_port_dia / 2)
        extrude(amount=-wall_thickness - 1, mode=Mode.SUBTRACT)

        # Step 5: Add lid screw holes on top rim
        # These are countersunk holes for lid attachment
        with BuildSketch(Plane.XY.offset(height)):
            with GridLocations(corner_spacing_x, corner_spacing_y, 2, 2):
                Circle(lid_screw_dia / 2)
        extrude(amount=-wall_thickness * 2, mode=Mode.SUBTRACT)

        # Step 6: Fillet external bottom edge
        external_bottom_edges = edges().filter_by(  # type: ignore
            lambda shape: abs(shape.center().Z) < 0.1  # type: ignore
        )

        if len(external_bottom_edges) > 0:
            chamfer(external_bottom_edges, length=1, length2=None)  # type: ignore

    return enclosure.part  # type: ignore


def create_lid(
    length=BOX_LENGTH,
    width=BOX_WIDTH,
    wall_thickness=WALL_THICKNESS,
    lid_screw_dia=LID_SCREW_DIA,
    lid_screw_inset=LID_SCREW_INSET,
):
    """
    Create a matching lid for the enclosure.

    Demonstrates simpler Builder Mode usage for flat parts.

    Returns:
        Solid: The lid
    """
    lid_thickness = wall_thickness
    lip_depth = wall_thickness
    lip_height = 5

    with BuildPart() as lid:
        # Main lid plate
        Box(
            length,
            width,
            lid_thickness,
            align=(Align.CENTER, Align.CENTER, Align.MIN),
        )

        # Add lip that fits into enclosure
        with Locations(Plane.XY.offset(lid_thickness)):
            Box(
                length - 2 * wall_thickness - 0.5,  # -0.5mm clearance
                width - 2 * wall_thickness - 0.5,
                lip_height,
                align=(Align.CENTER, Align.CENTER, Align.MIN),
            )

        # Screw holes for attachment
        corner_spacing_x = length - 2 * lid_screw_inset
        corner_spacing_y = width - 2 * lid_screw_inset

        with GridLocations(corner_spacing_x, corner_spacing_y, 2, 2):
            Hole(lid_screw_dia / 2, lid_thickness + lip_height)

        # Add handle recess on top
        with Locations(Plane.XY.offset(lid_thickness)):
            with BuildSketch():
                RectangleRounded(30, 10, 2)
            extrude(amount=-lid_thickness / 2, mode=Mode.SUBTRACT)

    return lid.part


# Create the parts
enclosure = create_enclosure()  # type: ignore
lid = create_lid()  # type: ignore

# Display information
print("=== Enclosure ===")
print(f"Volume: {enclosure.volume:.2f} mm³")  # type: ignore
print(f"Surface area: {enclosure.area:.2f} mm²")  # type: ignore
print(f"Bounding box: {enclosure.bounding_box().size}")  # type: ignore
print(f"Faces: {len(enclosure.faces())}")  # type: ignore
print(f"Edges: {len(enclosure.edges())}")  # type: ignore

print("\n=== Lid ===")
print(f"Volume: {lid.volume:.2f} mm³")  # type: ignore
print(f"Surface area: {lid.area:.2f} mm²")  # type: ignore
print(f"Bounding box: {lid.bounding_box().size}")  # type: ignore

# Export
# Uncomment to export:
# export_step(enclosure, "enclosure.step")
# export_step(lid, "lid.step")
# export_stl(enclosure, "enclosure.stl")
# export_stl(lid, "lid.stl")

# For visualization with ocp_vscode:
# from ocp_vscode import show, show_object
# show_object(enclosure, name="enclosure")
# show_object(lid * Pos(0, 0, BOX_HEIGHT + 10), name="lid")  # Offset lid above

# Example: Create assembly with both parts
with BuildPart() as assembly:
    add(enclosure)  # type: ignore
    # Position lid above enclosure
    with Locations(Pos(0, 0, BOX_HEIGHT + 10)):  # type: ignore
        add(lid)  # type: ignore

print("\n--- Builder Mode Key Takeaways ---")
print("1. Contexts manage state automatically (BuildPart, BuildSketch)")
print("2. Locations apply to all children in context")
print("3. GridLocations/PolarLocations for patterns")
print("4. Mode parameter controls boolean operations")
print("5. Selectors work on pending objects (edges(), faces())")
print("6. Great for complex assemblies and patterns")
print("7. Plane positioning for features on different faces")
print("8. Nested contexts create hierarchical structures")
