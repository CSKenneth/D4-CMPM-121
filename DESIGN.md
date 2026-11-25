# Design

Fill this in as you go. Your partner, future teammates, and the review bot read it
to learn where your project is headed. Replace each _italic prompt_.

## Target

This creature is Luffy from one piece and their main food source is a fruit called a gomu gomu frui. 
Luffy lives on a boat in the sea and everytime time he eats a fruit his neck or body gets longer allowing him
to reach the next fruits.

## Menu choices

Two items from two different groups (see the D4 guide's "The menu" tab).

| Item | Group | Done when (in your words) |
| --- | --- | --- |
|Power Ups| System | Multiple power ups that affect either the player or map |
| Sound as code | Content | atleast 3 game events that play sounds |

## Words we use

Each word your project uses, what it means, and where it lives in code. A few are
already here from the starter; keep them accurate as you change things.

| Word | Meaning | In code |
| --- | --- | --- |
| cell | one square of the grid | `Vector2i` |
| session | one run at the game, from the first tick until it ends; owns the board and the dragon | `Session` in `core/session.gd` |
| tick | one step of the rules; the dragon moves one cell | `Session.tick()`, `Dragon.tick()` |
| tile kind | what a cell is made of, such as `floor` or `wall` | `Board.TILES`, `TILES` in `tools/build_art.py` |
| piece | one model in the kit: head, straight, turn, tail | `Kit.Piece`, `PIECES` in `tools/build_art.py` |
| _word_ | _meaning_ | _where_ |
| Fruit | The food that the player eats | `build_art.py`|
| Growth | The rate at which a player grows | `dragon.gd`, `build_art.py` |

## Where things live

The rudes live in core/, the drawing happens in app/, and events get from one to the other by gonig through main.gd

## Adding a tile kind

1. Add a row to Board.TILES and indecate if it is a solid or not
2. Add a function in tools/build_art.py 
3. Run deno task art to render it and deno task preview to preview it
4. If there are rules add rule logic to session.tick
5. Test

## Patterns, and what they bought us

Command - turn queue in dragon
Flyweight - the shared meshes in main.gd
Type Object - Board.TITLES as data rather than a class per tile

## One idea we carried over

Idea: Keeping core seperate from framework
Problem: rules tanged with renderin change be tested without a window
Practice: a seperated core with a adapter with a gate that checks it
Mechanism: RefCounted instead of Nodes

## Sources we relied on

Claims about how Godot or Blender behaves, checked against the documentation for the
versions we run (Godot 4.7, Blender 5.2). Add a row when a decision depends on one.

| Claim | Source (link) | How we checked it |
| _what the tool does_ | _manual page or source file_ | _what we ran or looked at_ |
| glTF exporter copies a principled BSDF's unconnected base color into glTF material | https://docs.blender.org/manual/en/latest/addons/scene_gltf2.html | set skin, hat, and fruit colors in `tools/build_art.py`, ran deno task art and verified in deno task ci and den otask dev |

| -- | -- |
