## One run at the game: the board and the dragon on it, from the first tick until the
## run ends. Rules that involve more than the dragon (food, score, what the dragon can
## run into) belong here, so Dragon stays about movement and app/ only draws.
class_name Session
extends RefCounted

const GROWTH := 2

var board: Board
var dragon: Dragon

## food and growth
var food: Vector2i
var score := 0
var rng := RandomNumberGenerator.new()

## start and end
var started := false
var over := false


func _init(grid_size: Vector2i, seed_value := 121) -> void:
	board = Board.bordered(grid_size)
	dragon = Dragon.new(grid_size)
	rng.seed = seed_value
	food = _free_cell()


## One step of the rules. TODO for D4: food, growth, and collisions with the dragon's
## own body and with solid tiles (board.is_solid). Each needs the dragon and something
## else, which is why they go here rather than in Dragon.tick.
func tick() -> void:
	if not started or over:
		return
	dragon.tick()
	var head := dragon.body[0]
	if board.is_solid(head) or dragon.body.slice(1).has(head):
		over = true
		return
	if head == food:
		score += 1
		dragon.grow(GROWTH)
		food = _free_cell()


#random cell that isn't under the dragon
func _free_cell() -> Vector2i:
	var open: Array[Vector2i] = []
	for cell in board.tiles:
		if not board.is_solid(cell) and not dragon.body.has(cell):
			open.append(cell)
	return open[rng.randi_range(0, open.size() - 1)]


func start() -> void:
	started = true


func steer(direction: Vector2i) -> void:
	start()
	dragon.turn(direction)
