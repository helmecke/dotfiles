# pyright: basic
"""
Algebra Mode Example: Parametric Mounting Bracket

This example demonstrates build123d Algebra Mode for creating a simple
but complete parametric mounting bracket suitable for mechanical applications.

Key Algebra Mode patterns shown:
- Explicit object creation and manipulation
- Operator-based transformations (+, -, *)
- Manual location positioning with Pos()
- Selector usage for feature selection
- Filleting and chamfering operations

The bracket has:
- Base plate with mounting holes
- Vertical arm with through hole
- Filleted and chamfered edges
"""

from build123d import *  # type: ignore

# Parameters - modify these to change the design
BASE_WIDTH = 50
BASE_LENGTH = 30
BASE_THICKNESS = 5

ARM_WIDTH = 10
ARM_HEIGHT = 20
ARM_OFFSET = 0  # Offset from base edge

MOUNT_HOLE_DIA = 4
MOUNT_HOLE_SPACING_X = 40
MOUNT_HOLE_SPACING_Y = 20

ARM_HOLE_DIA = 6
ARM_HOLE_HEIGHT = 10

FILLET_RADIUS = 1
CHAMFER_LENGTH = 0.5


def create_bracket(
    base_width=BASE_WIDTH,
    base_length=BASE_LENGTH,
    base_thickness=BASE_THICKNESS,
    arm_width=ARM_WIDTH,
    arm_height=ARM_HEIGHT,
    arm_offset=ARM_OFFSET,
    mount_hole_dia=MOUNT_HOLE_DIA,
    mount_hole_spacing_x=MOUNT_HOLE_SPACING_X,
    mount_hole_spacing_y=MOUNT_HOLE_SPACING_Y,
    arm_hole_dia=ARM_HOLE_DIA,
    arm_hole_height=ARM_HOLE_HEIGHT,
    fillet_radius=FILLET_RADIUS,
    chamfer_length=CHAMFER_LENGTH,
):
    """
    Create a parametric mounting bracket using Algebra Mode.

    All dimensions in millimeters.

    Returns:
        Solid: The complete bracket
    """

    # Step 1: Create base plate
    # Algebra mode - explicit object creation
    base = Box(
        base_width,
        base_length,
        base_thickness,
        align=(Align.CENTER, Align.CENTER, Align.MIN),
    )

    # Step 2: Add mounting holes to base
    # Using Pos() to position holes explicitly
    hole_offset_x = mount_hole_spacing_x / 2
    hole_offset_y = mount_hole_spacing_y / 2

    # Create holes at four corners
    base -= Pos(hole_offset_x, hole_offset_y, 0) * Hole(
        mount_hole_dia / 2, base_thickness
    )
    base -= Pos(-hole_offset_x, hole_offset_y, 0) * Hole(
        mount_hole_dia / 2, base_thickness
    )
    base -= Pos(hole_offset_x, -hole_offset_y, 0) * Hole(
        mount_hole_dia / 2, base_thickness
    )
    base -= Pos(-hole_offset_x, -hole_offset_y, 0) * Hole(
        mount_hole_dia / 2, base_thickness
    )

    # Step 3: Create vertical arm
    arm = Pos(arm_offset, 0, base_thickness) * Box(
        arm_width,
        base_length,
        arm_height,
        align=(Align.MIN, Align.CENTER, Align.MIN),
    )

    # Step 4: Add through hole to arm
    # Position at center height of arm
    arm_hole_z = base_thickness + arm_hole_height
    arm -= Pos(arm_offset + arm_width / 2, 0, arm_hole_z) * Cylinder(
        arm_hole_dia / 2,
        arm_width + 1,  # Slightly longer to ensure through hole
        align=(Align.CENTER, Align.CENTER, Align.CENTER),
        rotation=(0, 90, 0),  # Rotate to be horizontal
    )

    # Step 5: Combine base and arm
    bracket = base + arm

    # Step 6: Fillet vertical edges between base and arm
    # Use selectors to find specific edges
    # Filter for edges that are vertical (parallel to Z axis)
    # and of specific length (arm height)
    vertical_edges = (
        bracket.edges()
        .filter_by(Axis.Z)
        .filter_by(
            lambda shape: abs(shape.length - arm_height) < 0.01  # type: ignore
        )
    )

    if len(vertical_edges) > 0:
        bracket = fillet(vertical_edges, radius=fillet_radius)

    # Step 7: Chamfer bottom edges of base
    # Select edges at Z=0 (bottom of base)
    bottom_edges = bracket.edges().filter_by(
        lambda shape: abs(shape.center().Z) < 0.01  # type: ignore
    )

    if len(bottom_edges) > 0:
        bracket = chamfer(bottom_edges, length=chamfer_length)

    return bracket


# Create the bracket with default parameters
bracket = create_bracket()

# Example: Further modify the result using Algebra Mode
# Add a reinforcement rib
rib_thickness = 2
rib = Pos(ARM_OFFSET + ARM_WIDTH / 2 - rib_thickness / 2, 0, BASE_THICKNESS) * Box(
    rib_thickness,
    BASE_LENGTH * 0.6,
    ARM_HEIGHT * 0.7,
    align=(Align.CENTER, Align.CENTER, Align.MIN),
)
bracket_with_rib = bracket + rib

# Fillet the rib edges
rib_edges = (
    bracket_with_rib.edges()
    .filter_by(lambda shape: abs(shape.center().X - (ARM_OFFSET + ARM_WIDTH / 2)) < 1.0)  # type: ignore
    .filter_by(Axis.Z)
)
if len(rib_edges) > 0:
    bracket_with_rib = fillet(rib_edges, radius=0.5)

print("\n--- Algebra Mode Key Takeaways ---")
print("1. Objects are explicit variables (base, arm, bracket)")
print("2. Transformations use Pos() and Rot() explicitly")
print("3. Boolean operations use operators: +, -, &")
print("4. Selectors return ShapeLists for filtering/sorting")
print("5. Operations return new objects (immutable style)")
print("6. Great for simple models and prototyping")
